
require 'rails_helper'

RSpec.feature 'Create a site spec', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let(:site_name) { 'Site name' }
  let(:body_text) { 'Description of the site' }

  scenario 'A user creates a site and visits it' do
    visit '/sites'

    # Log in
    click_link 'Add your rehab'
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Sign in'

    # Create a question
    expect(page).to have_content 'Tell us about your building'
    # fill_in "Give your site a name", with: site_name
    select "Commercial", :from => "site[building_type]"
    select "1,501-2,000", :from => "site[building_size]"

    fill_in "Tell us about your site. How did you find it? What did it look like at first? What do you love about it? You'll have an opportunity to add your rehab projects later.",
      with: body_text

    click_button 'Save your site. Next: add rehab projects'

    expect(page).to have_content 'Step 2: Add your first project'
  end
end
