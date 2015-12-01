class AddAttachmentPhotoToResources < ActiveRecord::Migration
  def self.up
    change_table :resources do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :resources, :photo
  end
end
