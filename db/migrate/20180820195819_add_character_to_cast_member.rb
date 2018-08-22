class AddCharacterToCastMember < ActiveRecord::Migration[5.1]
  def change
    add_column :crew_members, :character, :string
  end
end
