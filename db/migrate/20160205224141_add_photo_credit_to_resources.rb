class AddPhotoCreditToResources < ActiveRecord::Migration
  def change
    add_column :resources, :photo_credit, :string
  end
end
