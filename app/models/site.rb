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

class Site < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_many :projects
  belongs_to :user

  has_attached_file :photo, styles: { large: "1000x1000>", thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def generated_slug
    title
  end

  def building_type_enum
    ['House', 'Commercial', 'Religous', 'Instutional', 'Indstrial']
  end

  def building_size_enum
    ['<1,000', '1,000-1,200', '1,201-1,500', '1,501-2,000', '2,001-3,000', '3,001-5,000', '>5,000']
  end
end
