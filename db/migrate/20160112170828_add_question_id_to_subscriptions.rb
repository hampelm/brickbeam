class AddQuestionIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :question_id, :integer
  end
end
