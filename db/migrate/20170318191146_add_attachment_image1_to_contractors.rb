class AddAttachmentImage1ToContractors < ActiveRecord::Migration
  def self.up
    change_table :contractors do |t|
      t.attachment :image1
    end
  end

  def self.down
    remove_attachment :contractors, :image1
  end
end
