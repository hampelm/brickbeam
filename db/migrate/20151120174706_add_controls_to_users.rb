class AddControlsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :is_inactive, :boolean
  end
end
