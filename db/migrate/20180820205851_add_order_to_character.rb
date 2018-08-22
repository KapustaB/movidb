class AddOrderToCharacter < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :order, :integer
  end
end
