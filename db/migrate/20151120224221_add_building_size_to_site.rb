class AddBuildingSizeToSite < ActiveRecord::Migration
  def change
    add_column :sites, :building_size, :string
  end
end
