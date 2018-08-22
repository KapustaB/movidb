class ChangePublishDateToReleaseDate < ActiveRecord::Migration[5.1]
  def change
    rename_column :movies, :publish_date, :release_date
  end
end
