class AddQuestionEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :daily_question_digest, :boolean
  end
end
