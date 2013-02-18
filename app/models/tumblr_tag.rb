class TumblrTag < ActiveRecord::Base
  attr_accessible :tag

  validates_presence_of :tag

  has_many :entries, dependent: :destroy

  def fetch_and_parse
    url = "http://api.tumblr.com/v2/tagged?tag=#{self.tag.parameterize}&api_key=#{TUMBLR_KEY}"

    response_str = Curl::Easy.perform(url).body_str

    parsed = ActiveSupport::JSON.decode(response_str)

    return if !parsed["response"]

    parsed_entries = parsed["response"]

    parsed_entries.each do |parsed_entry|
      begin
        url = parsed_entry["photos"][0]["original_size"]["url"]
        self.entries.create(content: url, published: parsed_entry["date"], title: parsed_entry["caption"], link: parsed_entry["post_url"])
      rescue
      end
    end
  end
end
