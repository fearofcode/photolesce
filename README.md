Photolesce
----------

Photolesce is a little application that aggregates together RSS feeds of images and lets you browse them in a simple way.

The app is currently in its very early stages and is not ready for public use yet.

It filters Flickr photos by a fixed amount of favorites to make sure most of the photos are of decent quality. Otherwise, the timeline winds up being inundated with too many mediocre photos amongst the good ones. Currently, this threshold is 5. In order to keep the app simple, this is not currently a user-configurable setting.

Getting started
---------------

Photolesce should work like any normal Rails 3 app. All you need to do is deploy and then do the following:

- Generate a secret token using the built-in rake task: `rake generate_secret_token`
- Fill in the values in `config/initializers/secret_info.rb`. See `config/initializers/secret_info.rb.template` for an example of how to fill it in. You'll need to supply an admin password . If you want to work with Flickr feeds, you'll need a Flickr account so you can [apply for a Flickr API key](http://www.flickr.com/services/apps/create/noncommercial/?). To work with Tumblr content, sign up for a Flickr account and get a [Tumblr API key](http://www.tumblr.com/oauth/apps) by "registering a new application" and then pasting the "OAuth consumer key" in for the `TUMBLR_KEY` variable.

After you've deployed and configured it, head to the admin interface at `/feeds` to start adding content to aggregate.

Photolesce currently uses MySQL, so make a MySQL database named 'photolesce' and then fill out `config/database.yml.template` as you did with the secret_info file above.

You'll then want to put the rake tasks that fetch content on a cron job; make a cron job that runs `rake fetch_all RAILS_ENV=production`. Because this makes many API calls to Flickr, you'll only want to run it a few times a day.
