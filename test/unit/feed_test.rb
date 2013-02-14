require 'test_helper'
require 'feedzirra'

class FeedTest < ActiveSupport::TestCase
  def load_sample(filename)
    File.read("#{File.dirname(__FILE__)}/sample_feeds/#{filename}")
  end

  def parse_sample(filename)
    Feedzirra::Feed.parse(load_sample(filename))
  end

  def sample_atom_feed
    parse_sample("flickr_group_pool_atom.xml")
  end

  test "Setting the title from the feed" do
    feed = Feed.new
    Feedzirra::Feed.expects(:fetch_and_parse).returns(sample_atom_feed)
    
    feed.fetch_and_parse
    assert_equal "abstract photography Pool", feed.title
  end
end
