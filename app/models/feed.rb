require 'feedzirra'

class Feed < ActiveRecord::Base
  attr_accessible :etag, :last_modified, :title, :url, :fetched_ok

  has_many :entries, dependent: :destroy

  validates_presence_of :url
  validates_uniqueness_of :url, case_sensitive: false

  # not intended to be perfect, but rather good enough to catch basic errors
  validates_format_of :url, with: URI::regexp(%w(http https))

  def fetch_and_parse

    # TODO refactor this in some way besides just extracting methods that don't get called by anything else out

    Feedzirra::Feed.add_common_feed_entry_element("media:content", value: :url, as: :media_content)

    begin
      @parsed = Feedzirra::Feed.fetch_and_parse(url)

      self.site_url = @parsed.url
      self.title = @parsed.title
      self.last_modified = @parsed.last_modified
      self.etag = @parsed.etag
      self.fetched_ok = true
    rescue
      self.fetched_ok = false
    end

    save!

    return if !@parsed || !@parsed.respond_to?(:entries)

    for entry in @parsed.entries
      content = entry.respond_to?(:links) ? entry.links[1] : entry.media_content

      self.entries.create(content: content, link: entry.url, published: entry.published, title: entry.title)
    end

  end
end
