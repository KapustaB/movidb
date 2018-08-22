class AddTitleAndOverviewAndPublishDateToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :title, :string
    add_column :movies, :overview, :string
    add_column :movies, :publish_date, :date
  end
end
