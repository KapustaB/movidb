class RenameMovieGenderToMovieGenre < ActiveRecord::Migration[5.1]
  def change
    rename_table :movie_genders, :movie_genres
  end
end
