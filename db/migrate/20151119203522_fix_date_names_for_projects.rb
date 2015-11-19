class FixDateNamesForProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :created
    remove_column :projects, :edited
  end
end
