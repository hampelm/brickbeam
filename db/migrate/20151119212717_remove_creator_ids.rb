class RemoveCreatorIds < ActiveRecord::Migration
  def change
    remove_column :projects, :creator_id
    remove_column :sites, :creator_id
  end
end
