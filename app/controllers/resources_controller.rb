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

class ResourcesController < ApplicationController
  layout "resources"

  def index
    @resources = Resource.all
    @topics = Topic.all()

    @tags = ActsAsTaggableOn::Tag.all
  end

  def show
    @resource = Resource.friendly.find(params[:id])
    @topics = Topic.all()
    @related = Resource.tagged_with(@resource.tags, :any => true)
    @tags = ActsAsTaggableOn::Tag.all

    @related_by_tag = Hash.new []
    @related.each do |related|
      related.tags.each do |tag|
        @related_by_tag[tag] += [related]
      end
    end

  end

end
