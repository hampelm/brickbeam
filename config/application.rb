require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Brickbeam
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true

    # https://github.com/janfoeh/paperclip-optimizer#caution
    # Prevent image_optim conflicts
    config.assets.image_optim = false

    config.is_staging = ENV['IS_STAGING'] || false

    config.generators do |g|
      g.fixture_replacement :factory_girl
    end
    
    # Commented out for now -- no :must_be_admin! restriction on sign in page
    # config.to_prepare do
    #   Devise::SessionsController.skip_before_action :must_be_admin!
    # end
  end
end
