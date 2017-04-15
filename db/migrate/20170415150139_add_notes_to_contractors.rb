class AddNotesToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :notes, :text
  end
end
