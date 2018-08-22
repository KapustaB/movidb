class CreateMovieGenders < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_genders do |t|
      t.integer :movie_id
      t.integer :gender_id
    end
  end
end
