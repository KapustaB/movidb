class RenameActorIdToCrewMemberIdFromMovieCrewMember < ActiveRecord::Migration[5.1]
  def change
    rename_column :movie_crew_members, :actor_id, :crew_member_id
  end
end
