class AddResourcerefToAttachments < ActiveRecord::Migration
  def change
    add_reference :attachments, :resource, index: true, foreign_key: true
  end
end
