class AddMovieIdToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :movie_id, :integer
  end
end
