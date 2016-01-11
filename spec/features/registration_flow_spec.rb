require 'rails_helper'

RSpec.feature 'Registration flow', type: :feature do
  let(:email_address) { 'test_user@example.com' }
  let(:name) { 'Test Name' }
  let(:password) { 'password' }

  background do
    clear_emails
  end

  scenario 'Vistor registers for new account, sets password, logs out and logs in' do
    visit '/users/sign_up'

    fill_in 'Email', with: email_address
    fill_in 'Name', with: name
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    # page.has_selector?('#user_agreement') # This passes travis
    # check '#user_agreement' # This fails local + remote
    check 'user_agreement'

    click_button 'Sign up'
    expect(page).to have_text('Welcome, Test Name.')

    click_link 'Logout'
    expect(page).to have_content 'Log in'

    click_link 'Log in'
    fill_in 'Email', match: :first, with: email_address
    fill_in 'Password', match: :first, with: password
    click_button 'Sign in'
    expect(page).to have_content 'Logout'
  end
end
