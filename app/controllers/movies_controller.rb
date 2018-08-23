class MoviesController < ApplicationController
require 'movie_scraper'
require 'movies_query'
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :like]

  # GET /movies
  def index
    @movies = Movie.includes(:images).page(params[:page]).per(14)
    @genres = Genre.all.select('name, moviedb_genre_id')
    binding.pry
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

    render "index"
  end

  #GET /like movie
  def like
    likes = cookies[:liked_movies] unless cookies[:liked_movies].blank?
    (likes = Set.new) if likes.nil?

    likes.add(params[:id])

    cookies[:liked_movies] = likes

    @movie.likes = 1
    @movie.save

    render action: "index"
  end

  #GET /unlike movie
    def unlike
      likes = cookies[:likes][:liked_movies]
      likes.nil? ? likes = [] : likes.delete(params[:liked_movie_id])

      cookies[:likes] = {
          :liked_movies => likes,
          :expires => 1.year.from_now
      }
      Movie.find(params[:liked_movie_id]).likes -= 1
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
