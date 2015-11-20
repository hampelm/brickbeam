class AddBuildingTypeToSites < ActiveRecord::Migration
  def change
    add_column :sites, :building_type, :string
  end
end
