
require 'rails_helper'

RSpec.feature 'Delete a site spec', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let(:site_name) { 'Site name' }
  let(:body_text) { 'Description of the site' }

  let!(:religious_site) { FactoryGirl.create :site_with_project, :religious }
  let!(:residential_site) { FactoryGirl.create :site_with_project, :residential }

  scenario 'A user creates a site and deletes it before finishing' do
    visit '/sites'

    # Log in
    click_link 'Add your rehab'
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Sign in'

    # click_link 'Add your rehab'

    # Create a question
    expect(page).to have_content 'Tell us about your building'
    # fill_in "Give your site a name", with: site_name
    select "Commercial", :from => "site[building_type]"
    select "1,501-2,000", :from => "site[building_size]"

    fill_in "Tell us about your site. How did you find it? What did it look like at first? What do you love about it? You'll have an opportunity to add your rehab projects later.",
      with: body_text

    click_button 'Save your site. Next: add rehab projects'

    expect(page).to have_content 'Step 2: Add your first project'

    click_link 'Delete this rehab'
    expect(page.find('.brag-panel')).not_to have_content user.name
  end

  scenario 'A user creates a site with a project, then deletes the project' do
    visit '/'
    click_link 'Log in'

    # Log in
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: religious_site.user.email
    fill_in 'Password', match: :first, with: religious_site.user.password
    click_button 'Sign in'

    visit '/sites'

    click_link religious_site.title

    expect(page).to have_content religious_site.projects[0].description

    click_link 'Delete this project'
    expect(page.find('.brag-panel')).not_to have_content religious_site.projects[0].description
  end


  scenario 'A user creates a site with a project, then deletes the site' do
    visit '/'
    click_link 'Log in'

    # Log in
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: residential_site.user.email
    fill_in 'Password', match: :first, with: residential_site.user.password
    click_button 'Sign in'

    visit '/sites'

    click_link residential_site.title

    expect(page).to have_content residential_site.projects[0].description

    click_link 'Delete your rehab'
    expect(page.find('.brag-panel')).not_to have_content residential_site.title
  end

end
