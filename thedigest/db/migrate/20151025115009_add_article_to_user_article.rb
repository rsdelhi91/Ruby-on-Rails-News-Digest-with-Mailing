class AddArticleToUserArticle < ActiveRecord::Migration
  def change
    add_column :user_articles, :article_id, :integer
  end
end
