class RenamePersonIdToPeopleIdFromActor < ActiveRecord::Migration[5.1]
  def change
    rename_column :actors, :moviedb_person_id, :moviedb_people_id
  end
end
