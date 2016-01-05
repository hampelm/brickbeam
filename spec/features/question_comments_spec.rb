require 'rails_helper'

RSpec.feature 'User profile spec', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let(:title_text) { 'New question title' }
  let(:comment_text) { 'New comment text' }

  scenario 'A user asks a question and new comments are emailed to them' do
    visit '/questions'

    # Log in
    click_link 'Ask your question'
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Log in'

    # Create a question
    expect(page).to have_content 'Ask a question'
    fill_in "What's your question?", with: title_text
    click_button 'Ask!'

    # Add a comment
    expect(page).to have_content title_text
    fill_in 'comment_body', with: comment_text
    click_button 'Add your reply'

    open_email user.email
    expect(current_email.to).to include user.email
    expect(current_email.subject).to include title_text
    expect(current_email.body).to include comment_text
  end
end
