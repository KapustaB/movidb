class RenameMoviedbCastMemberIdToMoviedbPeopleIdFromCrewMembers < ActiveRecord::Migration[5.1]
  def change
    rename_column :crew_members, :moviedb_cast_member_id, :moviedb_people_id
  end
end
