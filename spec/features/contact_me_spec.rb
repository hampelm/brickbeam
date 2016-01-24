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
    open_email user_two.email
    expect(current_email.to).to include user.email
    expect(current_email.subject).to include 'Unsubscribe'
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
    visit users_path(contactable_user)
    expect(page).to have_content 'register to send them a message'
  end

  scenario 'Anonymous users do not see a prompt to log in if the user is uncontactable' do
    visit users_path(uncontactable_user)
    expect(page).not_to have_content 'register to send them a message'
  end

end
