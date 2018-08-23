class MovieScraper
  include HTTParty
  API_KEY = ENV["MOVIEDB_API_KEY"]

  base_uri 'https://api.themoviedb.org'

  def initialize(params = {})
    @options = { query: { } }
    @options[:query][:page] = params[:page] unless params[:page].nil?
  end

  def popular_movies
    self.class.get("/3/movie/popular?api_key=#{API_KEY}&language=en-US", @options)
  end

  def top_rated_movies
    self.class.get("/3/movie/top_rated?api_key=#{API_KEY}", @options)
  end

  def movie_credits(movie_id)
    self.class.get("/3/movie/#{movie_id}/credits?api_key=#{API_KEY}")
  end

  def now_playing_movies
    self.class.get("/3/movie/now_playing?api_key=#{API_KEY}&language=en-US", @options)
  end

  def latest_movies
    self.class.get("/3/movie/latest?api_key=#{API_KEY}&language=en-US")
  end

  def person_details(person_id)
    self.class.get("/3/person/#{person_id}?api_key=#{API_KEY}&language=en-US")
  end

  def movie_details(movie_id)
    self.class.get("/3/movie/#{movie_id}?api_key=#{API_KEY}&language=en-US")
  end

  def all_genres
    self.class.get("/3/genre/movie/list?api_key=#{API_KEY}&&language=en-US")
  end

end