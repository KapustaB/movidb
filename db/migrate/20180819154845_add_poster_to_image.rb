class AddPosterToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :poster, :string
  end
end
