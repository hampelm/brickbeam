source 'https://rubygems.org'
ruby '~>3.4'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.1.1'
gem 'puma' # Web server, not included with Rails 8
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sprockets-rails'  # Asset pipeline for Rails 8
gem 'dartsass-rails'
gem 'sassc-rails'  # SassC processor for Sprockets
# Use Terser as compressor for JavaScript assets (modern replacement for Uglifier)
gem 'terser'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'acts-as-taggable-on'
gem 'annotate'
# gem 'aws-sdk', '<2.0' # Disabled because it needs an old JSON
gem 'aws-sdk-s3'
# gem 'bootstrap-sass'  # Removed - using manual Bootstrap 3 import instead
gem 'bootstrap_form'
# gem 'ckeditor'  # Removed - not used in views and incompatible with Rails 8
# gem 'coveralls', require: false # Disabled because it uses an old json
gem 'devise'
gem 'font-awesome-rails'
gem 'friendly_id'
gem 'invisible_captcha'
# gem "lograge" # Temporarily disabled - incompatible with Rack 3
gem 'omniauth-facebook'
gem 'paperclip', git: 'https://github.com/sd/paperclip', branch: 'remove-mimemagic'
gem "image_optim_bin", group: :production # Must be before paperclip-optimizer
gem 'mimemagic', '0.4.3' # Smarter detection of mime types in file uploads
gem 'paperclip-optimizer'
gem 'pg'
gem 'pundit' # authorization
gem 'andand'
gem 'rails_admin'
gem 'rails_autolink'
gem 'redcarpet' # markdown parser
gem "skylight" # monitoring
gem 'slim'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'rails-jquery-autocomplete'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc



# Use ActiveModel has_secure_password
# (We use devise, which uses bcrypt)
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'dalli' # memcache
  gem 'heroku-deflater'
  gem 'memcachier' # heroku addon memcache service
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'poltergeist'
  # gem 'webmock'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'letter_opener' # Prevews email in the browser
  gem 'capybara-email'
  gem 'rspec-rails'
end

group :development do
  gem 'figaro' # Reads config/application.yml for local env variables
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'guard-scss-lint', require: false
  gem 'guard-shell', require: false
  gem 'html2slim', require: false
  gem 'rack-livereload'
  gem 'terminal-notifier-guard', require: false

  # gem 'html2slim'
  gem 'slim_lint'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end
