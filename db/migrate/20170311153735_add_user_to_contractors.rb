class AddUserToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :user_id, :integer
  end
end
