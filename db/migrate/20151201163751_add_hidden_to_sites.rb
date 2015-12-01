class AddHiddenToSites < ActiveRecord::Migration
  def change
    add_column :sites, :hidden, :boolean
  end
end
