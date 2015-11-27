== README

This is the rails app that powers Brick + Beam Detroit

# Deployment

# Dev install

These instructions are optimized for Mac. All components should have cross-platform equivalents, but you'll need to find the correct install process.

You'll need:

* phantomjs: `brew install phantomjs`

# Dev notes

## How to add slugs

## Events

rails generate model Event title:string description:text start_date:datetime end_date:datetime creator_id:integer

## Sites

rails generate model Site title:string description:text lat:decimal lng:decimal created:datetime edited:datetime creator_id:integer

## Projects

rails generate model Project description:text duration:string cost:string site:references creator_id:integer

## Questions

rails generate model Question title:string description:text slug:string creator_id:integer

## Comment

rails generate model Comment body:text question:references creator_id:integer

## Add a column to a model

rails generate acts_as_taggable_on:migration

rails generate migration AddSlugToSites slug:string

# Todo

http://stackoverflow.com/questions/28422222/using-action-mailer-for-new-comment-notification-rails-4
