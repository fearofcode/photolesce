ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def load_sample(filename)
    File.read("#{File.dirname(__FILE__)}/sample_feeds/#{filename}")
  end

  def parse_sample(filename)
    Feedzirra::Feed.add_common_feed_entry_element("media:content", value: :url, as: :media_content)
    Feedzirra::Feed.parse(load_sample(filename))
  end

  def sample_atom_feed
    parse_sample("flickr_group_pool_atom.xml")
  end

  def sample_rss_feed
    parse_sample("flickr_group_pool_rss.xml")
  end
end

require 'mocha/setup'
