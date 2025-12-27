require 'rails_helper'

RSpec.feature 'U', type: :feature do
  let!(:user) { FactoryBot.create :user }
  let(:title_text) { 'New question title' }
  let(:replacement_title_text) { 'Replacement question title' }
  let(:comment_text) { 'New comment text' }

  scenario 'A user asks a question and new comments are emailed to them' do
    visit '/questions'

    # TODO
    # Need to figure out how to add tags first.

    # Log in
    click_link 'Ask a question'
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Sign in'

    # Create a question
    expect(page).to have_content 'Ask a question'
    fill_in "What's your question?", with: title_text
    click_button 'Ask!'

    # Edit the question
    click_link 'Edit your question'
    fill_in "What's your question?", with: replacement_title_text
    click_button 'Ask!'

    expect(page).to have_content replacement_title_text
  end
end
