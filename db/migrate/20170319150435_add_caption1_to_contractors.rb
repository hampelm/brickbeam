class AddCaption1ToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :caption1, :text
  end
end
