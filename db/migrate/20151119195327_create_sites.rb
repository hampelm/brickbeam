class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :title
      t.text :description
      t.decimal :lat
      t.decimal :lng
      t.datetime :created
      t.datetime :edited
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
