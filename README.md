# Brick + Beam Detroit

This is the rails app that powers Brick + Beam Detroit.

![Rails Tests](https://github.com/hampelm/brickbeam/workflows/Rails%20Tests/badge.svg) [![Code Climate](https://codeclimate.com/github/hampelm/brickbeam/badges/gpa.svg)](https://codeclimate.com/github/hampelm/brickbeam) [![Coverage Status](https://coveralls.io/repos/github/hampelm/brickbeam/badge.svg?branch=master)](https://coveralls.io/github/hampelm/brickbeam?branch=master)

# Development

You may need to be using the proper version of Ruby (currently, 2.6). We
suggest using rvm to mangage versions. To switch to the correct version using rvm, run this command: `rvm use 2.6`

Start the app with `rails s`

Watch for sass changes and recompile, and run code linters with `guard` in a new tab.

## Setup

The first time you run this app, you'll need to do a little bit of setup.

These instructions are optimized for Mac. All components should have cross-
platform equivalents, but you'll need to find the correct install process. They expect you are running Ruby 2.2.3.

### You'll need

* phantomjs: `brew install phantomjs`
* [qt for capybara](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#homebrew) --
  check out the full install instructions
* A Postgres database

### First run

0.  Install bundler `gem install bundler:1.16.6`
1.  Install dependencies with `bundle install`
2.  Run the specs with `rake`
3.  Update the database with `rake db:migrate` if needed
4.  Run the server with `rails s`

## Staging

To protect a staging server, set the environment variable `IS_STAGING` to true
to require the user to be an admin to use the site.

## General development notes

To add model descriptions to relevant files, run the command `annotate` from the
project root.

We use `skylight` in production to monitor stats. You'll need to set the
`SKYLIGHT_AUTHENTICATION` environment variable for this to work.

### To run a specific test:

```
rspec spec/features/my_spec.rb
```

### To generate the daily email digest:

```
rake question_digest:create_and_send
```

### To resize thumbnails

`rake paperclip:refresh CLASS=Event`

The `paperclip-optimizer` gem has been installed but not activated. It provides
additional image compresion. Enable if page weight increases significantly.

# Deploying to Heroku

This app expects memcachier to be installed for [precaching assets](http://blog.alexmaccaw.com/faster-deploys). To set up, run:

```
heroku addons:add memcachier:dev
```

To enable or disable this, edit this line in `config/environments/production.rb`:

```
config.assets.cache_store = :dalli_store
```
