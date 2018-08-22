class AddMoviedbGenreIdToGenre < ActiveRecord::Migration[5.1]
  def change
    add_column :genres, :moviedb_genre_id, :integer
  end
end
