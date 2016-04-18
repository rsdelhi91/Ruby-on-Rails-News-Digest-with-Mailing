class AddRecvArticlesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :recvd_articles, :text
  end
end
