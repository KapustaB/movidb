class RenameMovieActorToMovieCrewMember < ActiveRecord::Migration[5.1]
  def change
    rename_table :movie_actors, :movie_crew_members
  end
end
