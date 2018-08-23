class SetDefaultValueToMovieLikes < ActiveRecord::Migration[5.1]
  def change
    change_column_default :movies, :likes, 0
  end
end
