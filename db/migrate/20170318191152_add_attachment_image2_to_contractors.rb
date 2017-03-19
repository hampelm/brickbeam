class AddAttachmentImage2ToContractors < ActiveRecord::Migration
  def self.up
    change_table :contractors do |t|
      t.attachment :image2
    end
  end

  def self.down
    remove_attachment :contractors, :image2
  end
end
