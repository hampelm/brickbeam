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

  config.excluded_models = ["Assets", "Attachment", "AttachmentFiles", "Picture", "Subscription", ]

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
      field :title
      field :user
      field :updated_at
    end

    edit do
      include_all_fields
      exclude_fields :slug

      fields_of_type :tag_list do
        partial 'tag_list_with_suggestions'

        # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
        ratl_max_suggestions -1
      end
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
      field :title
      field :start_date
    end

    edit do
      include_all_fields
      exclude_fields :slug, :user

      field :description, :ck_editor

      fields_of_type :tag_list do
        partial 'tag_list_with_suggestions'

        # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
        ratl_max_suggestions -1
      end
    end
  end

  config.model Topic do
    edit do
      include_all_fields

      fields_of_type :tag_list do
        partial 'tag_list_with_autocomplete'
      end
    end
  end

  config.model Resource do
    list do
      field :title
    end
    edit do
      include_all_fields
      exclude_fields :slug

      field :text, :ck_editor

      fields_of_type :tag_list do
        partial 'tag_list_with_suggestions'

        # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
        ratl_max_suggestions -1
      end
    end
  end
end
