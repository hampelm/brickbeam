class AddSlugToSites < ActiveRecord::Migration
  def change
    add_column :sites, :slug, :string
  end
end
