class CreateContractors < ActiveRecord::Migration
  def change
    create_table :contractors do |t|
      t.string :name
      t.string :business_name
      t.string :city
      t.string :address
      t.string :website
      t.string :phone
      t.string :email
      t.text :description
      t.string :slug
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
