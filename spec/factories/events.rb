# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :text
#  start_date         :datetime
#  end_date           :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#  user_id            :integer
#  location           :string
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  partner_event      :boolean
#

FactoryGirl.define do
  factory :event do
    title { FFaker::Lorem.phrase }
    location { FFaker::AddressUS.street_address }
    description { FFaker::Lorem.paragraph }
    start_date { 10.days.from_now }
    end_date { 11.days.from_now }
    partner_event { false }
  end
end
