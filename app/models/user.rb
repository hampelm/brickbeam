class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :agreement, acceptance: { accept: true }

  has_many :events
  has_many :sites
  has_many :projects
  has_many :questions
  has_many :comments
end
