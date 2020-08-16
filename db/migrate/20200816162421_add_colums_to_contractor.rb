class AddColumsToContractor < ActiveRecord::Migration
  def change
    add_column :contractors, :registered, :text
    add_column :contractors, :start_year, :int
    add_column :contractors, :trainings, :text
    add_column :contractors, :apprenticeship, :text
    add_column :contractors, :bonded, :text
    add_column :contractors, :license_bond, :text
  end
end
