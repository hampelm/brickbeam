source 'https://rubygems.org'
ruby '~>2.6.0' # Cannot go higher with Rails 4 because of BigDecimal


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'acts-as-taggable-on'
gem 'annotate'
gem 'aws-sdk-s3'
gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'ckeditor'
gem 'coveralls', require: false
gem 'devise'
gem 'font-awesome-rails'
gem 'friendly_id'
gem 'invisible_captcha'
gem "lograge" # Reduce log spam
gem 'omniauth-facebook'
gem 'paperclip', '6.1.0' # attachment
gem "image_optim_bin", group: :production # Must be before paperclip-optimizer
gem 'paperclip-optimizer'
gem 'pg'
gem 'pundit' # authorization
gem 'rails_admin', git: 'https://github.com/sferik/rails_admin.git', ref: 'c860b2f'
gem 'rails_admin_tag_list', git: 'https://github.com/kryzhovnik/rails_admin_tag_list.git', branch: 'master'
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
  gem 'rails_12factor'
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
  gem 'factory_girl_rails'
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
  gem 'guard-livereload', require: false
  gem 'html2slim', require: false
  gem 'rack-livereload'
  gem 'terminal-notifier-guard', require: false

  # gem 'html2slim'
  gem 'slim_lint'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

