== README

How to add users to posts:
http://guides.rubyonrails.org/association_basics.html
  So belongs_to user, as :creator
  With column name "creator_id"

Paperclip for assets
-- https://devcenter.heroku.com/articles/paperclip-s3

# How to add slugs

# Events

rails generate model Event title:string description:text start_date:datetime end_date:datetime creator_id:integer

# Sites

rails generate model Site title:string description:text lat:decimal lng:decimal created:datetime edited:datetime creator_id:integer

# Projects

rails generate model Project description:text duration:string cost:string site:references creator_id:integer


# Add a column to a model

rails generate acts_as_taggable_on:migration

rails generate migration AddSlugToSites slug:string
rails generate migration AddCreatedToProjects created:datetime
rails generate migration AddEditedToProjects edited:datetime
