# == Schema Information
#
# Table name: resources
#
#  id                 :integer          not null, primary key
#  title              :string
#  byline             :string
#  text               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

module ResourcesHelper
end
