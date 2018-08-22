class ImportPopularMoviesJob < ApplicationJob
  require 'movie_scraper'
  queue_as :default

  #Every page inserts 20 movies with related cast members, characters, actors and images

  def perform(num_of_pages)
    insert_movies_by_pages(num_of_pages)
  end

  private

  def insert_movies_by_pages(num_of_pages)
    (1..num_of_pages).each do |page_num|
      @movie_scraper = MovieScraper.new(page: page_num)
      response = @movie_scraper.popular_movies

      json = parse_response_to_json(response)

      insert_movies_into_db(json) unless json.empty?
    end
  end


  def insert_movies_into_db(json)
    json[:results].each do |m|
      next if m.blank?

      movie = create_movie(m)
      next if movie.nil?

      add_genres_to_movie(movie, select_movie_genres(m))

      import_cast_members(movie) unless movie.id.nil?

      store_movie_poster(m, movie)
    end
  end

  def create_movie(m)
    Movie.create!(
        title: m[:title],
        overview: m[:overview],
        release_date: m[:release_date],
        moviedb_id: m[:id]
    ) unless Movie.exists?(moviedb_id: m[:id])
  end

  def select_movie_genres(m)
    Genre.where(moviedb_genre_id: m[:genre_ids])
  end

  def add_genres_to_movie(movie, genres)
    movie.genres << genres unless genres.blank?
  end

  def parse_response_to_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def store_movie_poster(m, movie)
    poster_image = Image.create!(remote_poster_url: 'http://image.tmdb.org/t/p/w185/' + m[:poster_path]) unless m[:poster_path].blank?
    movie.images << poster_image
  end

  def import_movie_characters(characters)
    characters.map do |c|
      actor     = Actor.create!(
          name: c[:name],
          moviedb_people_id: c[:id],
          profile_path: c[:profile_path]
      ) unless Actor.exists?(moviedb_people_id: c[:id])

      character = Character.create!(name: c[:character], order: c[:order])

      character.actor = actor unless character.nil? || actor.nil?
      character
    end
  end


  def import_movie_crew_members(crew_members)
    crew_members.map do |cm|
      CrewMember.create!(
          moviedb_people_id: cm[:id],
          name: cm[:name],
          department: cm[:department],
          job: cm[:job]
      )unless CrewMember.exists?(moviedb_people_id: cm[:id])
    end
  end

  def get_movie_credits(movie_id)
    @movie_scraper.movie_credits(movie_id) unless movie_id.nil?
  end

  def import_cast_members(movie)
    movie_credits = parse_response_to_json( get_movie_credits(movie.id) ) unless movie.id.nil?

    characters = import_movie_characters(movie_credits[:cast]) unless movie_credits[:cast].blank?
    crew_members = import_movie_crew_members(movie_credits[:crew]) unless movie_credits[:crew].blank?


    bind_characters_to_movie(characters.compact, movie) unless characters.blank?
    bind_crew_members_to_movie(crew_members.compact, movie) unless crew_members.blank?
  end

  def bind_characters_to_movie(characters, movie)
    characters.each { |c| movie.characters << c unless movie.characters.exists?(c.id) }
  end

  def bind_crew_members_to_movie(crew_members, movie)
    crew_members.each { |c| movie.crew_members << c unless movie.crew_members.exists?(c.id) }
  end


end
