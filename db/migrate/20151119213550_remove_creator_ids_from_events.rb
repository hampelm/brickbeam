class RemoveCreatorIdsFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :creator_id
  end
end
