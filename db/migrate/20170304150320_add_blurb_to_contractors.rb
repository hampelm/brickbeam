class AddBlurbToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :blurb, :string
  end
end
