require 'test_helper'
require 'flickraw'

class EntryTest < ActiveSupport::TestCase
  test "Setting photo ID for Flickr photos" do
    entry = Entry.create(content: "http://farm9.staticflickr.com/8103/8476326710_f3a42343da_o.jpg")

    assert_equal "8476326710", entry.photo_id

    tumblr_entry = Entry.create(content: "http://www.tumblr.com/blah.jpg")

    assert_nil tumblr_entry.photo_id
  end

  test "Set title to 'Untitled' if no title provided" do
    entry = Entry.create(content: "http://foo.com/bar.jpg")

    assert_equal "Untitled", entry.title
  end

  test "Fetching favorite counts for Flickr photos" do
    entry = Entry.create(content: "http://foo.com/bar.jpg", photo_id: "12345")

    flickr.photos.expects(:getFavorites).with(photo_id: entry.photo_id).returns(stub(total: "42"))

    entry.fetch_favorite_count

    assert_equal 42, entry.favorite_cnt
  end

  test "Sets published date to current time when its favorite count crosses a threshold" do
    entry = Entry.create(content: "http://foo.com/threshold_test.jpg", published: 1.day.ago, favorite_cnt: Entry::FAV_THRESHOLD - 1)

    entry.favorite_cnt = Entry::FAV_THRESHOLD
    entry.save

    assert((Time.now - entry.published) < 1)
  end
end
