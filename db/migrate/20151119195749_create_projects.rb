class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :description
      t.string :duration
      t.string :cost
      t.references :site, index: true, foreign_key: true
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
