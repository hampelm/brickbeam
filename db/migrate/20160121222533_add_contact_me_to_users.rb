class AddContactMeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contact_me, :boolean
  end
end
