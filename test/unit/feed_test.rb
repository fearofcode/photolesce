require 'test_helper'
require 'feedzirra'

class FeedTest < ActiveSupport::TestCase
  test "Processing an image feed" do
    [sample_rss_feed, sample_atom_feed].each do |input_feed|
      feed = Feed.create(url: "http://foo.com/bar.rss")
      Feedzirra::Feed.stubs(:fetch_and_parse).returns(input_feed)

      feed.fetch_and_parse

      assert_equal "abstract photography Pool", feed.title
      assert_equal Time, feed.last_modified.class

      assert !feed.changed?
      assert feed.fetched_ok

      assert_equal input_feed.entries.count, feed.entries.count
      assert feed.entries.first.content.end_with?(".jpg")
      assert feed.entries.first.link.start_with?("http://www.flickr.com")
      assert_equal ActiveSupport::TimeWithZone, feed.entries.first.published.class

      feed.fetch_and_parse
      assert_equal input_feed.entries.count, feed.entries.count

      feed.destroy
    end
  end

  test "Set fetched_ok to false if download fails" do
    feed = Feed.new(url: "http://www.foo.com/bar.rss")
    Feedzirra::Feed.expects(:fetch_and_parse).throws(RuntimeError)

    feed.fetch_and_parse

    assert !feed.fetched_ok
  end
end
