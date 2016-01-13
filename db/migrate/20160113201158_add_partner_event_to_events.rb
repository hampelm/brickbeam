class AddPartnerEventToEvents < ActiveRecord::Migration
  def change
    add_column :events, :partner_event, :boolean
  end
end
