class ChangeDateToDatetime < ActiveRecord::Migration
  def change
    change_column :articles, :pubDate, :datetime
  end
end
