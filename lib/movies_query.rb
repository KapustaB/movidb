class MoviesQuery

  def initialize(filter_params)
    @filter_params = filter_params
    @movies = Movie.all
  end

  def perform
    return movies if filter_params.blank?

    filter_by_title
    filter_by_actor_names

    movies
  end

  private

  attr_accessor :movies
  attr_reader :filter_params


  def filter_by_actor_names
    result = movies.joins(:characters => :actor).where(
        'actors.name ILIKE ?', "%#{filter_params[:search]}%"
    ) unless filter_params[:search].blank?

    save_result_if_not_empty(result) unless result.nil?
  end

  def filter_by_title
    result = movies.where(
        'title ILIKE ?', "#{filter_params[:search]}%"
    ) unless filter_params[:search].blank?

    save_result_if_not_empty(result) unless result.nil?
  end

  def save_result_if_not_empty(result)
    self.movies = result unless result.blank?
  end

end