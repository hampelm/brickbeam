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
