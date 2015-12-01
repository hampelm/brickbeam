class AddHiddenToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :hidden, :boolean
  end
end
