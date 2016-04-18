class AddModifiedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :modified, :boolean, default: false
  end
end
