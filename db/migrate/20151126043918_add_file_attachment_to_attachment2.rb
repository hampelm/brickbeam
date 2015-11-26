class AddFileAttachmentToAttachment2 < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :file_attachment
    end
  end

  def self.down
    remove_attachment :attachments, :file_attachment
  end
end
