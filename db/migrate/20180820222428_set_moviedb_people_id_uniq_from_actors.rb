class SetMoviedbPeopleIdUniqFromActors < ActiveRecord::Migration[5.1]
  def change
    add_index :actors, :moviedb_people_id, unique: true
  end
end
