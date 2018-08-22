class AddProfilePathToActor < ActiveRecord::Migration[5.1]
  def change
    add_column :actors, :profile_path, :string
  end
end
