class RenameCharacterToJobFromCrewMembers < ActiveRecord::Migration[5.1]
  def change
    rename_column :crew_members, :character, :job
  end
end
