require 'rails_helper'

RSpec.feature 'Contact Me spec', type: :feature do
  let!(:user) { FactoryBot.create :user }
  let!(:digest_user) { FactoryBot.create :user, :daily_digest }

  let!(:questions) { FactoryBot.create_list(:question, 3) }
  let!(:old_question) { FactoryBot.create :question, :old }

  scenario 'A user gets the daily digest' do
    # Send the users questions
    generator = GenerateQuestionDigest.new
    generator.call

    # Check the contactee's email
    open_email digest_user.email
    expect(current_email.to).to include digest_user.email
    expect(current_email.body).to include 'Change your contact settings'

    # Make sure all the questions are listed
    questions.each do |question|
      expect(current_email.body).to include question.title
      current_email.click_link question.title
      expect(page).to have_content question.title
    end

    # Make sure old questions are not included
    expect(current_email.body).to_not include old_question.title
  end

  scenario 'A user can unsubscribe from the daily digest' do
    # Send the users questions
    generator = GenerateQuestionDigest.new
    generator.call

    # Check the contactee's email
    open_email digest_user.email
    expect(current_email.to).to include digest_user.email
    expect(current_email.body).to include 'Change your contact settings'

    # Make sure all the questions are listed
    questions.each do |question|
      expect(current_email.body).to include question.title
    end

    clear_emails

    # Sign in
    visit '/users/edit'
    expect(page).to have_content 'Log in'
    fill_in 'Email', match: :first, with: digest_user.email
    fill_in 'Password', match: :first, with: digest_user.password
    click_button 'Sign in'

    # Unsubscribe
    uncheck 'Send me a daily email with new rehab questions'
    fill_in 'Current password', match: :first, with: digest_user.password
    click_button 'Update'

    generator.call
    open_email digest_user.email
    expect(current_email).to be_nil
  end

  scenario 'A user who is not subscribed does not get the daily digest' do
    # Send the users questions
    generator = GenerateQuestionDigest.new
    generator.call

    open_email user.email
    expect(current_email).to be_nil
  end
end
