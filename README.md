== README

This is the rails app that powers Brick + Beam Detroit

# Deployment

Running the app: `rails s`

# Development

You may need to be using the proper version of Ruby (currently, 2.2.3). We
suggest using chruby to mangage versions. To switch to the correct version using
chruby, run this command: `chruby 2.2.3`

Start the app with `rails s`

Watch for sass changes and recompile, and run code linters with `guard` in a new
tab.

## Setup

The first time you run this app, you'll need to do a little bit of setup.

These instructions are optimized for Mac. All components should have cross-
platform equivalents, but you'll need to find the correct install process. They
expect you are running Ruby 2.2.3.

### You'll need

* phantomjs: `brew install phantomjs`
* A Postgres database

### First run

1. Install dependencies with `bundle install`
2. Run the specs with `rake`
3. Update the database with `rake db:migrate` if needed
4. Run the server with `rails s`

## Developing

To add model descriptions to relevant files, run the command `annotate` from the
project root.

