require 'rails_helper'

RSpec.feature 'Question creation spec', type: :feature do
  let!(:user) { FactoryGirl.create :user }
  let!(:locked_question) { FactoryGirl.create :question, :locked }
  let(:title_text) { 'New question title' }
  let(:comment_text) { 'New comment text' }

  scenario 'A user can ask questions and comment on them' do
    visit '/questions'

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

    # Add a comment
    expect(page).to have_content title_text
    fill_in 'comment_body', with: comment_text
    click_button 'Add your reply'
  end

  scenario 'A user cannot comment on locked questions' do
    visit '/questions'

    # Log in
    click_link 'Log in'
    fill_in 'Email', match: :first, with: user.email
    fill_in 'Password', match: :first, with: user.password
    click_button 'Sign in'

    # Try to answer the question
    visit '/questions'
    click_link locked_question.title
    expect(page).not_to have_content "Add your reply"
    expect(page).to have_content "This question is locked"
  end
end
