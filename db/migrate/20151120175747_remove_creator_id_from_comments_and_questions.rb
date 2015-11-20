class RemoveCreatorIdFromCommentsAndQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :creator_id
    remove_column :comments, :creator_id
  end
end
