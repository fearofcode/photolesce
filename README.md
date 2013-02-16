Photolesce
----------

Photolesce is a little application that aggregates together RSS feeds of images and lets you browse them in a simple way.

The app is currently in its very early stages and is not ready for public use yet.

Getting started
---------------

Photolesce should work like any normal Rails 3 app. All you need to do is deploy and then do the following:

Generate a secret token using the built-in rake task:

    $ rake generate_secret_token

[Apply for a Flickr API key](http://www.flickr.com/services/apps/create/noncommercial/?) (which will require a Flickr account) and fill in the values in `config/initializers/flickr_key.rb`. See `config/initializers/flickr_key.rb.template` for an example of how to fill it in. 
