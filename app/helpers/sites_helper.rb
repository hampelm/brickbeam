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

module SitesHelper
end
