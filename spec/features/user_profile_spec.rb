require 'rails_helper'

RSpec.feature 'User profile spec', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:user_two) { FactoryGirl.create :user }

  scenario 'A user creates a profile and visits it' do
    visit '/users/' + user.id.to_s
    expect(page).to have_content user.name
    expect(page).not_to have_content "Edit your account"

    # Log in
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
end
