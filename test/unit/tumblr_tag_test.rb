require 'test_helper'
require 'uri'

class TumblrTagTest < ActiveSupport::TestCase
  test "Processing Tumblr API requests" do
    tag = TumblrTag.create(tag: "art")
 
    sample_response = load_sample("tumblr_api_request.json")

    Curl::Easy.expects(:perform).with("http://api.tumblr.com/v2/tagged?tag=#{tag.tag}&api_key=#{TUMBLR_KEY}").returns(stub(body_str: sample_response))

    tag.fetch_and_parse

    assert_equal 20, tag.entries.size

    tag.entries.each do |entry|
      assert_match "media.tumblr.com", entry.content
      assert_equal ActiveSupport::TimeWithZone, entry.published.class
      assert entry.title?
      assert_equal URI::HTTP, URI::parse(entry.link).class
    end

  end

  test "Converting tags to slugs" do
    tag = TumblrTag.create(tag: "black and white")

    Curl::Easy.expects(:perform).with("http://api.tumblr.com/v2/tagged?tag=black-and-white&api_key=#{TUMBLR_KEY}").returns(stub(body_str: "{}"))
    
    tag.fetch_and_parse
  end
end
