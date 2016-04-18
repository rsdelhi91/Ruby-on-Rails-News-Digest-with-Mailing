class SetDefaultWeight < ActiveRecord::Migration
  def change
    change_column :articles, :weight, :double, default: 0.0
  end
end
