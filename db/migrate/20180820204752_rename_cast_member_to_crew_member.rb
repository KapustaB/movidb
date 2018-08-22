class RenameCastMemberToCrewMember < ActiveRecord::Migration[5.1]
  def change
    rename_table :cast_members, :crew_members
  end
end
