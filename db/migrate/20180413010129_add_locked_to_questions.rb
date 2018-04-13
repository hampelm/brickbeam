class AddLockedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :locked, :boolean
  end
end
