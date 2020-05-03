RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
    redirect_to main_app.root_path unless current_user.try(:is_admin?)
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  # config.excluded_models = ["Assets", "Picture", ]


  config.included_models = [
    'ActsAsTaggableOn::Tag', # Because this isn't in models/, we have to list all
    'Asset',
    'Attachment',
    'AttachmentFile',
    'Comment',
    'Contractor',
    'Event',
    'Page',
    'Picture',
    'Project',
    'Question',
    'Resource',
    'Site',
    'Subscription',
    'Topic',
    'User',
  ]

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model Question do
    list do
      sort_by :updated_at
      field :title
      field :user
      field :updated_at
    end

    edit do
      include_all_fields
      exclude_fields :slug, :base_tags

      # fields_of_type :tag_list do
      #   partial 'tag_list_with_suggestions'
      #   # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
      #   ratl_max_suggestions -1
      # end
    end
  end

  config.model User do
    list do
      sort_by :updated_at
      field :name
      field :email
    end
  end


  config.model Site do
    list do
      field :user
      field :updated_at
    end
  end

  config.model Page do
    edit do
      include_all_fields
      field :body, :ck_editor
    end
  end

  config.model Event do
    list do
      sort_by :updated_at
      field :title
      field :start_date
    end

    edit do
      include_all_fields
      exclude_fields :slug, :user, :base_tags

      field :description, :ck_editor

      # fields_of_type :tag_list do
      #   partial 'tag_list_with_suggestions'
      #   # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
      #   ratl_max_suggestions -1
      # end
    end
  end

  config.model Topic do
    edit do
      include_all_fields
      exclude_fields :base_tags

      # fields_of_type :tag_list do
      #   partial 'tag_list_with_autocomplete'
      #   # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
      #   ratl_max_suggestions -1
      # end
    end
  end

  config.model Contractor do
    list do
      sort_by :updated_at
      field :name
      field :business_name
      field :blurb
      field :approved
      field :updated_at
    end

    edit do
      include_all_fields
      exclude_fields :slug, :base_tags

      field :description, :ck_editor

      # fields_of_type :tag_list do
      #   partial 'tag_list_with_suggestions'
      #   # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
      #   ratl_max_suggestions -1
      # end
    end
  end

  config.model Resource do
    list do
      sort_by :updated_at
      field :title
      field :updated_at
    end

    edit do
      include_all_fields
      exclude_fields :slug, :base_tags

      field :text, :ck_editor

      # fields_of_type :tag_list do
      #   partial 'tag_list_with_suggestions'
      #   # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
      #   ratl_max_suggestions -1
      # end
    end
  end

  config.model Subscription do
    list do
      field :user
      field :question
    end
  end

end
