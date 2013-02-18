Photolesce
----------

Photolesce is a little application that aggregates together RSS feeds of images and lets you browse them in a simple way.

The app is currently in its very early stages and is not ready for public use yet.

It filters Flickr photos by a fixed amount of favorites to make sure most of the photos are of decent quality. Otherwise, the timeline winds up being inundated with too many mediocre photos amongst the good ones. Currently, this threshold is 5. In order to keep the app simple, this is not currently a user-configurable setting.

Getting started
---------------

Photolesce should work like any normal Rails 3 app. All you need to do is deploy and then do the following:

- Generate a secret token using the built-in rake task: `rake generate_secret_token`
- Fill in the values in `config/initializers/secret_info.rb`. See `config/initializers/secret_info.rb.template` for an example of how to fill it in. You'll need to supply an admin password . You'll also need a Flickr account, which you use to [apply for a Flickr API key](http://www.flickr.com/services/apps/create/noncommercial/?).
