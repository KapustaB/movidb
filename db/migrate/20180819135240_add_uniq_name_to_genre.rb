class AddUniqNameToGenre < ActiveRecord::Migration[5.1]
  def change
    add_index :genres, :name, unique: true
  end
end
