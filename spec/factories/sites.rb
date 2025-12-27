# == Schema Information
#
# Table name: sites
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :text
#  lat                :decimal(, )
#  lng                :decimal(, )
#  created            :datetime
#  edited             :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#  user_id            :integer
#  building_type      :string
#  building_size      :string
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  hidden             :boolean
#

FactoryBot.define do
  factory :site do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.paragraph }
    user
    building_size { '1,501-2,000' }
    building_type { 'Commercial' }

    trait :residential do
      building_type { 'House' }
    end

    trait :religious do
      building_type { 'Religious' }
    end

    factory :site_with_project do
      after(:create) do |site, evaluator|
        create(:project, site: site)
      end
    end
  end
end
