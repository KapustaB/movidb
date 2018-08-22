class RenameActorToCastMembers < ActiveRecord::Migration[5.1]
  def change
    rename_table :crew_members, :crew_members
  end
end
