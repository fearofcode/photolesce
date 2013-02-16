require 'test_helper'
require 'flickraw'

class EntryTest < ActiveSupport::TestCase
  test "Setting photo ID for Flickr photos" do
    entry = Entry.create(content: "http://farm9.staticflickr.com/8103/8476326710_f3a42343da_o.jpg")

    assert_equal "8476326710", entry.photo_id

    tumblr_entry = Entry.create(content: "http://www.tumblr.com/blah.jpg")

    assert_nil tumblr_entry.photo_id
  end

  test "Fetching favorite counts for Flickr photos" do
    entry = Entry.create(content: "http://foo.com/bar.jpg", photo_id: "12345")

    flickr.photos.expects(:getFavorites).with(photo_id: entry.photo_id).returns(stub(total: "42"))

    entry.fetch_favorite_count

    assert_equal 42, entry.favorite_cnt
  end
end
