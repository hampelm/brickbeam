require 'rails_helper'

RSpec.feature 'User profile spec', type: :feature do
  let!(:admin) { FactoryGirl.create :admin }
  let!(:user)  { FactoryGirl.create :user  }

  after(:each) do 
    Rails.configuration.is_staging = false
  end

  scenario 'On staging, only admin users can log in' do
    Rails.configuration.is_staging = true
    visit '/'
    expect(page).to have_content 'Sign in'
    expect(page).not_to have_content "Welcome to Detroit's Rehabber Community"

    # Log in
    fill_in 'Email', match: :first, with: admin.email
    fill_in 'Password', match: :first, with: admin.password
    click_button 'Sign in'

    # The admin should be able to visit the homepage
    visit '/'
    expect(page).to have_content "Welcome to Detroit's Rehabber Community"
  end
end
