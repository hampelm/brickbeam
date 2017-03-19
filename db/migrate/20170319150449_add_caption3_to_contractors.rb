class AddCaption3ToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :caption3, :text
  end
end
