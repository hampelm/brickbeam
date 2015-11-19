class AddEditedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :edited, :datetime
  end
end
