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

FactoryGirl.define do
  factory :contractor do
    name { FFaker::Name.name }
    business_name { FFaker::Company.name }
    city { FFaker::Address.city }
    address { FFaker::Address.street_address }
    website { FFaker::Internet.http_url }
    phone { FFaker::PhoneNumber.short_phone_number }
    email { FFaker::Internet.email }
    description { FFaker::Lorem.paragraphs }
    approved true
  end
end
