class AddAttachmentImage3ToContractors < ActiveRecord::Migration
  def self.up
    change_table :contractors do |t|
      t.attachment :image3
    end
  end

  def self.down
    remove_attachment :contractors, :image3
  end
end
