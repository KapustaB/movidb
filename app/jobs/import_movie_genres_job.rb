class ImportMovieGenresJob < ApplicationJob
  queue_as :default
  require 'movie_scraper'

  API_KEY = ENV["MOVIEDB_API_KEY"]


  def perform(*args)
    response = @movie_scraper.all_genres

    genres = parse_response_to_json(response)

    insert_genres_into_db(genres) unless genres.empty?
  end

  private

  def insert_genres_into_db(json)
    json[:genres].map do |e|
      Genre.create(moviedb_genre_id: e[:id], name: e[:name])
    end
  end

  def parse_response_to_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end


