require 'rails_helper'

RSpec.feature 'Contact Me spec', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:contactable_user) { FactoryGirl.create :user, :contactable }
  let!(:uncontactable_user) { FactoryGirl.create :user, :uncontactable }

  scenario 'A new user can be contacted' do
    # Sign as a user
    visit '/users/sign_in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Sign in'

    # The user should be contactable
    visit '/users/' + contactable_user.id.to_s
    fill_in 'body', with: 'My message here'
    click_button 'Contact ' + contactable_user.name

    expect(page).to have_content "We've forwarded your message to " + contactable_user.name

    # Check the contactee's email
    open_email contactable_user.email
    expect(current_email.from).to include user.email
    expect(current_email.to).to include contactable_user.email
    expect(current_email.body).to include 'Change your contact settings'
    expect(current_email.body).to include 'My message here'
    expect(current_email.body).to include user.email
    expect(current_email.body).to include user.name
  end

  scenario 'A new user who opts out cannot be contacted' do
    # Sign as a user
    visit '/users/sign_in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Sign in'

    # The user should not be contactable
    expect(page).not_to have_content("Contact")
  end

  scenario 'Anonymous users see a prompt to log in if the user is contactable' do
    visit '/users/' + contactable_user.id.to_s
    expect(page).to have_content 'register to send them a message'
  end

  scenario 'Anonymous users do not see a prompt to log in if the user is uncontactable' do
    visit '/users/' + uncontactable_user.id.to_s
    expect(page).not_to have_content 'register to send them a message'
  end

end
