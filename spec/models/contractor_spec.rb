# == Schema Information
#
# Table name: contractors
#
#  id            :integer          not null, primary key
#  name          :string
#  business_name :string
#  city          :string
#  address       :string
#  website       :string
#  phone         :string
#  email         :string
#  description   :text
#  slug          :string
#  approved      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Contractor, type: :model do
  it "has a valid factory" do
    FactoryGirl.create(:contractor).should be_valid
  end

  it "uses the contractor name and business name as the slug" do
    @contractor = Contractor.new({
      name: 'flibblesnort',
      business_name: 'wocky'
    })
    @contractor.save
    assert_equal 'wocky-flibblesnort', @contractor.slug
  end

  it "slug is ok with just a name" do
    @contractor = Contractor.new({
      name: 'Flibblesnort Hobgoblin'
    })
    @contractor.save
    assert_equal 'flibblesnort-hobgoblin', @contractor.slug
  end

  it "slug is ok with just a business name" do
    @contractor = Contractor.new({
      business_name: 'wocky-flock'
    })
    @contractor.save
    assert_equal 'wocky-flock', @contractor.slug
  end
  
end
