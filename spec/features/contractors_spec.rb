require 'rails_helper'

RSpec.feature 'Creating ', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:admin) { FactoryGirl.create :admin }

  let(:biz)         { 'Biz name' }
  let(:person_name) { 'Person name' }
  let(:phone)       { '555-555-5555' }
  let(:website)     { 'http://example.com' }
  let(:email)       { 'sample@example.com' }
  let(:city)        { 'Detroit' }
  let(:description) { 'Biz description' }

  scenario 'Users can suggest a contractor' do
    visit '/contractors'

    # Log in
    click_link 'Suggest a contractor'
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Sign in'

    # Create a contractor
    expect(page).to have_content 'Submit a contractor recommendation'

    fill_in "Contractor's business name (if they have one)",    with: biz
    fill_in "Contractor's name",                                with: person_name
    fill_in "Phone number",                                     with: phone
    fill_in "Email address",                                    with: email
    fill_in "Website",                                          with: website
    fill_in "In what city are they based? (eg 'Detroit' or 'Warren')", with: city
    # fill_in "Tell us more about the contractor",                with: description
    click_button 'Submit your recommendation'

    # Get redirected back to the root with a flash
    expect(page).to have_content 'Thanks for your recommendation'
    expect(page).to_not have_content biz

    # Make sure the admin gets emailed
    open_email admin.email
    expect(current_email.to).to include admin.email
    expect(current_email.subject).to include biz
    expect(current_email.body).to include biz
  end

  pending "Check the admin link in the notification email"
end

RSpec.feature 'Viewing ', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:admin) { FactoryGirl.create :admin }
  let!(:contractor) { FactoryGirl.create :contractor }
  let!(:contractor2) { FactoryGirl.create :contractor }
  let!(:contractor3) { FactoryGirl.create :contractor }

  
  scenario "has a basic index page" do
    contractors = [contractor, contractor2, contractor3]

    visit '/contractors'

    contractors.each do |contractor|
      expect(page).to have_content contractor.title
      expect(page).to have_content contractor.city
    end
  end

  scenario "contractors show information" do
    visit "/contractors/#{contractor.slug}"

    expect(page).to have_content contractor.title
    expect(page).to have_content contractor.phone
    expect(page).to have_content contractor.email
  end
end

