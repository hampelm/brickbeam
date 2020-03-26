# == Schema Information
#
# Table name: contractors
#
#  id                  :integer          not null, primary key
#  name                :string
#  business_name       :string
#  city                :string
#  address             :string
#  website             :string
#  phone               :string
#  email               :string
#  description         :text
#  slug                :string
#  approved            :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  blurb               :string
#  user_id             :integer
#  image1_file_name    :string
#  image1_content_type :string
#  image1_file_size    :integer
#  image1_updated_at   :datetime
#  image2_file_name    :string
#  image2_content_type :string
#  image2_file_size    :integer
#  image2_updated_at   :datetime
#  image3_file_name    :string
#  image3_content_type :string
#  image3_file_size    :integer
#  image3_updated_at   :datetime
#  caption1            :text
#  caption2            :text
#  caption3            :text
#  notes               :text
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

  it "knows if they're in detroit, highland park, or hamtramck" do
    @contractor = Contractor.new({
      business_name: 'wocky-flock',
      city: 'HaMTRamck'
    })
    @contractor.save
    assert_equal true, @contractor.local?
  end

  it "knows if they're not in detroit, highland park, or hamtramck" do
    @contractor = Contractor.new({
      business_name: 'wocky-flock'
    })
    @contractor.save
    assert_equal false, @contractor.local?
  end

  it 'should validate one name or another' do
    contractor = Contractor.new
    contractor.valid?
    contractor.errors[:base][0].should include("add a name")

    contractor.name = 'Jones'
    contractor.valid?
    expect(contractor.errors[:title]).to be_empty

    contractor.name = nil
    contractor.valid?
    contractor.errors[:base][0].should include("add a name")

    contractor.business_name = 'Company name'
    contractor.valid?
    expect(contractor.errors[:base]).to be_empty


    contractor.business_name = 'Company name'
    contractor.name = 'Jones'
    contractor.valid?
    expect(contractor.errors[:base]).to be_empty

  end
end
