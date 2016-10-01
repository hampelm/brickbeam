source 'https://rubygems.org'
ruby '2.3.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.6'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'acts-as-taggable-on', '~> 3.4'
gem 'annotate'
gem 'aws-sdk', '<2.0'
gem 'bootstrap-sass', '~> 3.3.5'
gem 'bootstrap_form'
gem 'ckeditor', '~> 4.1.4'
gem 'devise', '~> 3.5.2'
gem 'font-awesome-rails'
gem 'friendly_id', '~> 5.1'
gem 'omniauth-facebook'
gem 'paperclip', '~>4.3' # attachment
gem "image_optim_bin", group: :production # Must be before paperclip-optimizer
gem 'paperclip-optimizer'
gem 'pg', '~>0.18'
gem 'pundit', '~> 1.0.1' # authorization
# gem 'rails_admin', '~> 0.8.0'
gem 'rails_admin', :github => 'sferik/rails_admin', :ref => 'c860b2f'

gem 'rails_admin_tag_list', git: 'https://github.com/kryzhovnik/rails_admin_tag_list.git', branch: 'master'
gem 'redcarpet' # markdown parser
gem 'slim'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'rails-jquery-autocomplete'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

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
  gem 'capybara-webkit'
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

