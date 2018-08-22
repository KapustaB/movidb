class ImportMovieGenresJob < ApplicationJob
  queue_as :default
  require 'httparty'

  API_KEY = ENV["MOVIEDB_API_KEY"]
  API_ENDPOINT = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{API_KEY}&&language=en-US"


  def perform(*args)
    response = HTTParty.get(API_ENDPOINT)
    json = JSON.parse(response.body, symbolize_names: true)

    insert_genres_into_db(json) unless json.empty?
  end

  private

  def insert_genres_into_db(json)
    json[:genres].map do |e|
      Genre.create(moviedb_genre_id: e[:id], name: e[:name])
    end
  end

end

