# == Schema Information
#
# Table name: contractors
#
#  id            :integer          not null, primary key
#  name          :string
#  business_name :string
#  city          :string
#  address       :string
#  website       :string
#  phone         :string
#  email         :string
#  description   :text
#  slug          :string
#  approved      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null


class ContractorsController < ApplicationController
  layout "contractors"

  def index
    @contractors = Contractor.order('updated_at DESC').all
    @topics = Topic.all

    @tags = ActsAsTaggableOn::Tag.all.sort_by { |obj| obj.name.downcase }
  end

  def show
    @contractor = Contractor.friendly.find(params[:id])
    @topics = Topic.all()
    @related = Contractor.tagged_with(@contractor.tags, :any => true).limit(6)
    @tags = ActsAsTaggableOn::Tag.all.sort_by { |obj| obj.name.downcase }

    @related_by_tag = Hash.new []
    @related.each do |related|
      related.tags.each do |tag|
        @related_by_tag[tag] += [related]
      end
    end

  end

end
