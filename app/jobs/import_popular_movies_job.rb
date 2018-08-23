class ImportPopularMoviesJob < ApplicationJob
  require 'movie_scraper'
  queue_as :default

  #Every page inserts 20 movies with related cast members, characters, actors and images

  def perform(num_of_pages)
    (1..num_of_pages).each do |page_num|
      popular_movies = get_popular_movies_from_moviedb(page_num)

      popular_movies[:results].each do |m|
        next if m.blank?
        movie = create_movie(m)
        next if movie.nil?

        add_genres_to_movie(movie, select_movie_genres(m))
        add_movie_poster(m, movie)

        movie_credits = get_movie_credits(movie.id) unless movie.id.nil?

        ImportCastMembersService.new({movie: movie, movie_credits: movie_credits}).perform unless movie.id.nil?

      end unless popular_movies[:results].nil?
    end
  end

  private

  def get_popular_movies_from_moviedb(page_num)
    @movie_scraper = MovieScraper.new(page: page_num)
    response = @movie_scraper.popular_movies

    parse_response_to_json(response)
  end

  def get_movie_credits(movie_id)
    credits = @movie_scraper.movie_credits(movie_id) unless movie_id.nil?
    parse_response_to_json(credits)
  end

  def create_movie(m)
    Movie.create!(movie_params(m)) unless Movie.exists?(moviedb_id: m[:id])
  end

  def movie_params(m)
    {title: m[:title], overview: m[:overview], release_date: m[:release_date], moviedb_id: m[:id]}
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

  def add_movie_poster(m, movie)
    poster_image = Image.create!(remote_poster_url: 'http://image.tmdb.org/t/p/w185/' + m[:poster_path]) unless m[:poster_path].blank?
    movie.images << poster_image
  end


end
