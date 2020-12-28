require 'rails_helper'

RSpec.feature 'Event spec', type: :feature do
  let!(:event) { FactoryGirl.create :event }

  scenario 'Events are displayed' do
    visit '/events'

    expect(page).to have_content event.title

    date = event.start_date.strftime('%b %-d')
    expect(page).to have_content date
  end
end
