class Project < ActiveRecord::Base
  acts_as_taggable

  belongs_to :site
  belongs_to :user
end
