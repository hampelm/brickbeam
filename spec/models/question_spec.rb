# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  hidden      :boolean
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'should validate presence' do
    question = Question.new
    question.title = ''
    question.valid?.should be false
    question.errors[:title].should include("can't be blank")

    question.title = 'Sample title'
    question.valid?.should be true
    question.errors[:title].should_not include("can't be blank")
  end

  it 'should validate length' do
    question = Question.new
    question.title = "a" * 176 # Our cutoff is 175 characters
    question.valid?.should be false

    question.title = "a" * 175
    question.valid?.should be true
  end
end
