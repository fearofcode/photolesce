require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  test "Setting photo ID for Flickr photos" do
    entry = Entry.create(content: "http://farm9.staticflickr.com/8103/8476326710_f3a42343da_o.jpg")

    assert_equal "8476326710", entry.photo_id

    tumblr_entry = Entry.create(content: "http://www.tumblr.com/blah.jpg")

    assert_nil tumblr_entry.photo_id
  end
end
