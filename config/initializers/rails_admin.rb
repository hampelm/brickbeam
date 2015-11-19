RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

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

  config.model Event do
    list do
      field :title
    end
    edit do
      include_all_fields

      field :description, :ck_editor

      field :slug do
        help 'Optional - set automatically by the system'
      end

      fields_of_type :tag_list do
        partial 'tag_list_with_suggestions'

        # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
        ratl_max_suggestions -1
      end
    end
  end

  config.model Resource do
    list do
      field :title
    end
    edit do
      include_all_fields

      field :text, :ck_editor

      field :slug do
        help 'Optional - set automatically by the system'
      end

      fields_of_type :tag_list do
        partial 'tag_list_with_suggestions'

        # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
        ratl_max_suggestions -1
      end
    end
  end
end
