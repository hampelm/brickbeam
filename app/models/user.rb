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


class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  scope :subscribed_to_question_digest, -> { where(daily_question_digest: true) }

  validates :agreement, acceptance: { accept: true }
  validates :name, presence: true

  has_many :events
  has_many :sites
  has_many :projects
  has_many :questions
  has_many :comments

  # Block some users from signing up
  before_validation do
    email = self.email
    russian = email.ends_with? '.ru'
    hotmales = email.include? 'hotmails'
    yandex = email.include? 'yandex'
    random = email[5..9] == 'email'
    thefmail = email.include? 'thefmail'
    haxx = email.include? 'haxx'
    periods = email.count('.') > 3
    mixed = email.include? 'mix-mail'

    tld = email.split('.').last
    weird_tld = !['com', 'net', 'org', 'edu', 'co.uk'].include?(tld)

    if russian || hotmales || yandex || random || thefmail || haxx || periods || weird_tld || mixed
      errors.add(:email, 'Not allowed')
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
