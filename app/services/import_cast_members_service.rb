class ImportCastMembersService

  attr_accessor :movie, :movie_credits

  def initialize(params)
    @movie = params[:movie]
    @movie_credits = params[:movie_credits]
  end

  def perform
    characters = import_movie_characters(movie_credits[:cast]) unless movie_credits[:cast].blank?
    crew_members = import_movie_crew_members(movie_credits[:crew]) unless movie_credits[:crew].blank?

    bind_characters_to_movie(characters.compact, movie) unless characters.blank?
    bind_crew_members_to_movie(crew_members.compact, movie) unless crew_members.blank?
  end

  private

  def import_movie_characters(characters)
    characters.map do |c|
      actor = create_actor(c)
      character = create_character(c)

      character.actor = actor unless character.nil? || actor.nil?
      character
    end
  end

  def create_actor(c)
    Actor.create!(actor_params(c)) unless Actor.exists?(moviedb_people_id: c[:id])
  end

  def create_character(c)
    Character.create!(character_params(c))
  end

  def import_movie_crew_members(crew_members)
    crew_members.map do |cm|
      CrewMember.create!(crew_member_params(cm)) unless CrewMember.exists?(moviedb_people_id: cm[:id])
    end
  end


  def bind_characters_to_movie(characters, movie)
    characters.each { |c| movie.characters << c unless movie.characters.exists?(c.id) }
  end

  def bind_crew_members_to_movie(crew_members, movie)
    crew_members.each { |c| movie.crew_members << c unless movie.crew_members.exists?(c.id) }
  end

  def crew_member_params(cm)
    { moviedb_people_id: cm[:id], name: cm[:name], department: cm[:department], job: cm[:job]}
  end

  def actor_params(c)
    {name: c[:name], moviedb_people_id: c[:id], profile_path: c[:profile_path]}
  end

  def character_params(c)
    {name: c[:character], order: c[:order]}
  end
end