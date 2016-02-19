# Brick + Beam Detroit

This is the rails app that powers Brick + Beam Detroit.

[![Build Status](https://travis-ci.org/hampelm/brickbeam.svg?branch=master)](https://travis-ci.org/hampelm/brickbeam) [![Code Climate](https://codeclimate.com/github/hampelm/brickbeam/badges/gpa.svg)](https://codeclimate.com/github/hampelm/brickbeam) [![Dependency Status](https://gemnasium.com/hampelm/brickbeam.svg)](https://gemnasium.com/hampelm/brickbeam)

# Development

You may need to be using the proper version of Ruby (currently, 2.2.3). We
suggest using chruby to mangage versions. To switch to the correct version using chruby, run this command: `chruby 2.2.3`

Start the app with `rails s`

Watch for sass changes and recompile, and run code linters with `guard` in a new tab.

## Setup

The first time you run this app, you'll need to do a little bit of setup.

These instructions are optimized for Mac. All components should have cross-
platform equivalents, but you'll need to find the correct install process. They expect you are running Ruby 2.2.3.

### You'll need

* phantomjs: `brew install phantomjs`
* A Postgres database

### First run

1. Install dependencies with `bundle install`
2. Run the specs with `rake`
3. Update the database with `rake db:migrate` if needed
4. Run the server with `rails s`

## General development notes

To add model descriptions to relevant files, run the command `annotate` from the
project root.

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



