class ImportCastMembersService

  attr_accessor :movie, :movie_credits

  NUM_OF_IMPORT_CREW = 10

  def initialize(params)
    @movie = params[:movie]
    @movie_credits = params[:movie_credits]
  end

  def perform
    characters = import_movie_characters(movie_credits[:cast]) unless movie_credits[:cast].blank?
    crew_members = import_or_find_movie_crew_members(movie_credits[:crew]) unless movie_credits[:crew].blank?

    bind_characters_to_movie(characters.compact, movie) unless characters.blank?
    bind_crew_members_to_movie(crew_members.compact, movie) unless crew_members.blank?
  end

  private

  def import_movie_characters(characters)
    characters.first(NUM_OF_IMPORT_CREW).map do |character|
      actor = find_or_create_actor(character)
      character = create_character(character)


      character.actor = actor unless character.nil? || actor.nil?
      character
    end
  end

  def find_or_create_actor(actor)
     Actor.create(
         profile_path: actor[:profile_path],
         moviedb_people_id: actor[:id],
         name: actor[:name]
     ) unless Actor.exists?(moviedb_people_id: actor[:id])
  end

  def create_character(c)
    Character.create(character_params(c))
  end

  def import_or_find_movie_crew_members(crew_members)
    crew_members.first(NUM_OF_IMPORT_CREW).map do |crew_member|

      CrewMember.create(
        moviedb_people_id: crew_member[:id],
        name: crew_member[:name],
        department: crew_member[:department],
        job: crew_member[:job]
      ) unless CrewMember.exists?(moviedb_people_id: crew_member[:id])
    end
  end

  def bind_characters_to_movie(characters, movie)
    characters.each { |character| movie.characters << character unless movie.characters.exists?(character.id) }
  end

  def bind_crew_members_to_movie(crew_members, movie)
    crew_members.each { |crew_member| movie.crew_members << crew_member unless movie.crew_members.exists?(crew_member.id) }
  end

  def character_params(character)
    {name: character[:character], order: character[:order]}
  end
end