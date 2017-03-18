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
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :protect_dev_features!

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag' 

  def index
    @contractors = Contractor.approved
    @tags = @contractors.tags_on(:tags)
  end

  def show
    @contractor = Contractor.friendly.find(params[:id])
    @topics = Topic.all()
    @related_contractors = Contractor.tagged_with(@contractor.tags, :any => true).limit(4)
    @tags = ActsAsTaggableOn::Tag.all.sort_by { |obj| obj.name.downcase }

    @resources = Resource.tagged_with(@contractor.tags, :any => true).limit(3)
    @events = Event.tagged_with(@contractor.tags, :any => true).limit(3)
    @questions = Question.tagged_with(@contractor.tags, :any => true).limit(3)
    @projects = Project.tagged_with(@contractor.tags, :any => true).limit(3)

    @related_by_tag = Hash.new []
    @related_contractors.each do |related|
      related.tags.each do |tag|
        @related_by_tag[tag] += [related]
      end
    end
  end

  def new
    @contractor = Contractor.new
    @tags = ActsAsTaggableOn::Tag.all
    @tags_sorted = @tags.sort_by { |obj| obj.name.downcase }
  end

  def create
    @contractor = Contractor.new(contractor_params)
    @contractor.user = current_user
    @contractor.save

    if @contractor.save
      email_admins(@contractor)
      flash[:notice]  = "Thanks for your recommendation! We review submissions regularly. Yours will appear here once approved."
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  private
    def contractor_params
      params.require(:contractor).permit(:name, :business_name, :tag_list, :description, 
        :phone, :website, :email, :city, :image1, :image2, :image3)
    end

    def email_admins(contractor)
      admins = User.where(:is_admin => true)

      admins.each do |admin|
        # Don't email users about their own comments.
        if contractor.user != admin
          NotificationMailer.new_contractor_email(admin, contractor).deliver_later
        end
      end
    end

end
