class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.text :name

      t.timestamps null: false
    end
  end
end
