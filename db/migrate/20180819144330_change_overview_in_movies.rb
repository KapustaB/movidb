class ChangeOverviewInMovies < ActiveRecord::Migration[5.1]
  def change
    change_column :movies, :overview, :text
  end
end
