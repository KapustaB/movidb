class RenameMoviedbActorIdToMoviedbCastMemberIdFromCastMember < ActiveRecord::Migration[5.1]
  def change
    rename_column :cast_members, :moviedb_actor_id, :moviedb_cast_member_id
  end
end
