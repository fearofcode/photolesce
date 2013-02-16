require 'uri'
require 'flickraw'

class Entry < ActiveRecord::Base
  attr_accessible :content, :link, :published, :title, :photo_id, :favorite_cnt

  belongs_to :feed

  validates_presence_of :content
  validates_uniqueness_of :content

  default_scope order('published DESC')

  before_save :set_photo_id

  def set_photo_id
    begin
      parsed = URI::parse(content)

      return if !parsed.host.ends_with?("flickr.com")

      path_parts = parsed.path.split('/')
      self.photo_id = path_parts[2].split("_")[0]
    rescue
      logger.error "Entry ID #{id} could not be parsed"
    end
  end

  def fetch_favorite_count
    return if !photo_id

    begin
      favs = flickr.photos.getFavorites(photo_id: photo_id)

      self.favorite_cnt = favs.total.to_i
    rescue
      self.favorite_cnt = 0
    end
  end
end
