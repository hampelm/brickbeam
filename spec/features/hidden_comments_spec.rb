require 'rails_helper'

RSpec.feature 'Hidden comments spec', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let(:title_text) { 'New question title' }
  let(:comment_text) { 'New comment text' }

  let!(:question) { FactoryGirl.create :question_with_hidden_comment }

  scenario 'A user creates a comment and views it' do
    visit '/questions'

    # Log in
    click_link 'Ask a question'
    expect(page).to have_content 'Welcome to Brick + Beam'
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

    expect(page).to have_content comment_text
  end

  scenario 'Users cannot see hidden comments' do
    visit '/questions'

    # Go to the sample question
    expect(page).to have_content question.title
    click_link(question.title)

    expect(page).not_to have_content(question.comments.first.body)

    # Hide the comment
  end
end
