class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :like, :unlike]
  require 'movie_scraper'
  require 'movies_query'
  require 'json'

  # GET /movies
  def index
    @movies = Movie.includes(:images).page(params[:page]).per(14)
    @genres = Genre.all.select('name, moviedb_genre_id')
  end

  # GET /movies/1
  def show
    @moviedb = get_movie_from_moviedb(@movie)
  end

  # GET /Sort movies by genre
  def sort_by_genre
    @movies = select_movies_by_genre

    @movies = @movies.page(params[:page]).per(14)
    @genre = params[:genre_name]

    render action: "index"
  end

  #PUT /like movie
  def like
    likes = parse_likes_from_cookies
    likes = add_movie_like(likes)

    cookies[:liked_movies] = likes

    @movie.likes += 1
    @movie.save
  end

  #PUT /unlike movie
    def unlike
      likes = parse_likes_from_cookies
      likes = delete_movie_like(likes)

      cookies[:liked_movies] = likes

      @movie.likes -= 1
      @movie.save
    end

  def search
    @movies = MoviesQuery.new({search: params[:search]}).perform
    @movies = @movies.page(params[:page]).per(14)

    render "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def add_movie_like(likes)
      if likes.nil?
        likes= Array.new
        likes.push(params[:id].to_i)
      else
        likes.push(params[:id].to_i)
      end

      JSON.generate(likes) unless likes.nil?
    end

    def delete_movie_like(likes)
      likes = likes.push(params[:id].to_i)
      JSON.generate(likes) unless likes.nil?
    end

    def parse_likes_from_cookies
      (JSON.parse cookies[:liked_movies]) unless cookies[:liked_movies].blank?
    end

    def select_movies_by_genre
      Movie.joins(:genres).where("moviedb_genre_id = ?", params[:moviedb_genre_id])
    end

    def get_movie_from_moviedb(movie)
      movie_scraper = MovieScraper.new
      response = movie_scraper.movie_details(movie.moviedb_id)
      JSON.parse(response.body, symbolize_names: true)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.fetch(:movie, {})
    end
end
