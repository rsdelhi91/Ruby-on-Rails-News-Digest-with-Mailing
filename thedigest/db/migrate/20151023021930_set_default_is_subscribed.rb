class SetDefaultIsSubscribed < ActiveRecord::Migration
  def change
    change_column :users, :isSubscribed, :boolean, default: false
  end
end
