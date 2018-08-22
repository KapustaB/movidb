class MoviesController < ApplicationController
require 'movie_scraper'
require 'movies_query'
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.includes(:images).page(params[:page]).per(14)
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    movie_scraper = MovieScraper.new
    response = movie_scraper.movie_details(@movie.moviedb_id)
    @moviedb =JSON.parse(response.body, symbolize_names: true)
  end

  def sort_by_genre
    @movies = Movie.joins(:genres).where("moviedb_genre_id = ?", params[:moviedb_genre_id])
    @movies = @movies.page(params[:page]).per(14)
    @genre = params[:genre_name]
    render "index"
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.fetch(:movie, {})
    end
end
