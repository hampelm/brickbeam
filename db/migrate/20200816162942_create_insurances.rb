class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
