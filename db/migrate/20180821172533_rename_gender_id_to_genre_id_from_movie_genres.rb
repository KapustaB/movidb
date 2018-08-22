class RenameGenderIdToGenreIdFromMovieGenres < ActiveRecord::Migration[5.1]
  def change
    rename_column :movie_genres, :gender_id, :genre_id
  end
end
