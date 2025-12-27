require 'rails_helper'

RSpec.feature 'Question comment notification spec', type: :feature do
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user }
  let(:title_text) { 'New question title' }
  let(:comment_text) { 'New comment text' }

  scenario 'A user asks a question and new comments are emailed to them' do
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

    # Log out
    click_link 'Logout'
    visit '/questions'
    click_link title_text

    # Log in as the second user
    click_link 'Log in', match: :first
    fill_in 'Email', match: :first, with: user2.email
    fill_in 'Password', match: :first, with: user2.password
    click_button 'Sign in'

    # Go back to the question
    # TODO: in the future, this redirect will happen automatically
    visit '/questions'
    click_link title_text

    fill_in 'comment_body', with: comment_text
    click_button 'Add your reply'

    open_email user.email
    expect(current_email.to).to include user.email
    expect(current_email.subject).to include title_text
    expect(current_email.body).to include comment_text
  end

  scenario 'A user asks a question, opts out of notifications, and does not recieve any' do
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
    uncheck "Send me an email when new replies are posted"

    click_button 'Ask!'
    expect(page).to have_content title_text

    # Log out
    click_link 'Logout'
    visit '/questions'
    click_link title_text

    # Log in as the second user
    click_link 'Log in', match: :first
    fill_in 'Email', match: :first, with: user2.email
    fill_in 'Password', match: :first, with: user2.password
    click_button 'Sign in'

    # Go back to the question
    # TODO: in the future, this redirect will happen automatically
    visit '/questions'
    click_link title_text

    fill_in 'comment_body', with: comment_text
    click_button 'Add your reply'

    open_email user.email
    expect(current_email).to be_nil
  end

  scenario 'A user asks a question, unsubscribes from notifications, and does not recieve any more' do
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
    expect(page).to have_content title_text

    # Unsubscribe
    click_button  "Unsubscribe from notifications"

    # Log out
    click_link 'Logout'
    visit '/questions'
    click_link title_text

    # Log in as the second user
    click_link 'Log in', match: :first
    fill_in 'Email', match: :first, with: user2.email
    fill_in 'Password', match: :first, with: user2.password
    click_button 'Sign in'

    # Go back to the question
    # TODO: in the future, this redirect will happen automatically
    visit '/questions'
    click_link title_text

    fill_in 'comment_body', with: comment_text
    click_button 'Add your reply'

    open_email user.email
    expect(current_email).to be_nil
  end
end
