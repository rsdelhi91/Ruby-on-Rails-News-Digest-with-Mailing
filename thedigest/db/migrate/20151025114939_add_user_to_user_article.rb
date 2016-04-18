class AddUserToUserArticle < ActiveRecord::Migration
  def change
    add_column :user_articles, :user_id, :integer
  end
end
