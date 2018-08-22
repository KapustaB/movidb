class CreateActor < ActiveRecord::Migration[5.1]
  def change
    create_table :actors do |t|
      t.string :name
      t.integer :moviedb_person_id
    end
  end
end
