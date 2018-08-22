class AddMoviedbActorIdAndNameToActor < ActiveRecord::Migration[5.1]
  def change
    add_column :crew_members, :moviedb_actor_id, :integer
    add_column :crew_members, :name, :string
  end
end
