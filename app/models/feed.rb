require 'feedzirra'

class Feed < ActiveRecord::Base
  attr_accessible :etag, :last_modified, :title, :url

  has_many :entries

  validates_presence_of :url
  validates_uniqueness_of :url, case_sensitive: false

  # not intended to be perfect, but rather good enough to catch basic errors
  validates_format_of :url, with: URI::regexp(%w(http https))

  def fetch_and_parse
    feed = Feedzirra::Feed.fetch_and_parse(url)

    self.title = feed.title
  end
end
