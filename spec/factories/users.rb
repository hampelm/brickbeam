# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  is_admin               :boolean
#  is_inactive            :boolean
#  agreement              :boolean
#  provider               :string
#  uid                    :string
#  contact_me             :boolean
#  daily_question_digest  :boolean
#

def fake_email
  FFaker::Internet.user_name + '@example.com'
end


FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { fake_email }
    password { 'password' }
    password_confirmation { 'password' }

    trait :admin do
      is_admin { true }
    end

    trait :contactable do
      contact_me { true }
    end

    trait :uncontactable do
      contact_me { false }
    end

    trait :daily_digest do
      daily_question_digest { true }
    end

    trait :unconfirmed do
      password { nil }
      password_confirmation { nil }
      confirmed_at { nil }
    end

    factory :admin, traits: [:admin]
    factory :unconfirmed_user, traits: [:unconfirmed]
  end
end
