class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.string :bio
      t.boolean :isSubscribed
      t.datetime :tsOld
      t.datetime :tsRecent

      t.timestamps null: false
    end
  end
end
