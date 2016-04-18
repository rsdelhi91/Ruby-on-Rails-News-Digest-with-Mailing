class CreateUserArticles < ActiveRecord::Migration
  def change
    create_table :user_articles do |t|
      t.timestamps null: false
    end
  end
end
