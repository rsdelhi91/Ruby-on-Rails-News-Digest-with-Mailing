class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :source
      t.string :author
      t.date :pubDate
      t.string :summary
      t.string :link
      t.string :imageURL

      t.timestamps null: false
    end
  end
end
