class AddAttachmentPhotoToSites < ActiveRecord::Migration
  def self.up
    change_table :sites do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :sites, :photo
  end
end
