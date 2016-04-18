class AddWeightToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :weight, :double
  end
end
