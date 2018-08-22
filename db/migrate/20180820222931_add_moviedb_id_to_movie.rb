class AddMoviedbIdToMovie < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :moviedb_id, :integer
    add_index :movies, :moviedb_id, unique: true
  end
end
