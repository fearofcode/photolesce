require 'test_helper'
require 'feedzirra'

class FeedTest < ActiveSupport::TestCase
  test "Processing an image feed" do
    [sample_rss_feed, sample_atom_feed].each do |input_feed|
      feed = Feed.create(url: "http://foo.com/bar.rss")
      Feedzirra::Feed.stubs(:fetch_and_parse).returns(input_feed)
      Feedzirra::Feed.stubs(:update).returns(input_feed)

      feed.fetch_and_parse

      assert_equal "abstract photography Pool", feed.title
      assert_equal ActiveSupport::TimeWithZone, feed.last_modified.class
      assert_equal "http://www.flickr.com/groups/abstrato/pool/", feed.site_url
      assert !feed.changed?
      assert feed.fetched_ok

      assert_equal 20, feed.entries.count
      assert feed.entries.first.content.end_with?(".jpg")
      assert feed.entries.first.link.start_with?("http://www.flickr.com")
      assert_equal ActiveSupport::TimeWithZone, feed.entries.first.published.class
      assert feed.entries.first.title?

      feed.fetch_and_parse
      assert_equal 20, feed.entries.count
      feed.destroy
    end
  end

  test "Set fetched_ok to false if download fails" do
    feed = Feed.new(url: "http://www.foo.com/bar.rss")
    Feedzirra::Feed.expects(:fetch_and_parse).throws(RuntimeError)

    feed.fetch_and_parse

    assert !feed.fetched_ok

    feed.destroy
  end

  test "Updates properly after downloading the first time" do
    feed = Feed.create!(url: "http://www.foo.com/to_be_updated.rss", last_modified: Time.now)
    feed.entries.create!(content: "http://www.foo.com/bar.jpg", link: "http://www.foo.com/blah.html")

    Feedzirra::Feed.expects(:update).once

    feed.fetch_and_parse

    feed.destroy
  end
end
