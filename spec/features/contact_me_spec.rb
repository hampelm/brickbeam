require 'rails_helper'

RSpec.feature 'Contact Me spec', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  # let!(:user_two) { FactoryGirl.create :user }

  scenario 'A new user can be contacted' do
    visit '/users/sign_in'
    expect(page).to have_content 'Sign up'
    expect(page).not_to have_content "Edit your account"

    # Register
    click_link 'Log in'
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Sign in'

    # The user should have a link to edit their account
    visit '/users/' + user.id.to_s
    expect(page).to have_content user.name
    expect(page).to have_content "Edit your account"

    # the user should not have a linkt o
    visit '/users/' + user_two.id.to_s
    expect(page).to have_content user_two.name
    expect(page).not_to have_content "Edit your account"
  end

  scenario 'A new user who opts out cannot be contacted' do
  end

  scenario 'A user who disables contacts cannot be contacted' do
  end

  scenario 'Anonymous users see a prompt to contact a user' do
    visit users_path(user)
    expect(page).to have_content 'Sign in to contact'
  end
end
