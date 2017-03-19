class AddCaption2ToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :caption2, :text
  end
end
