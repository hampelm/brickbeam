class AddCreatedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :created, :datetime
  end
end
