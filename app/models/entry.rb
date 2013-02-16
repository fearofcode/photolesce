require 'uri'

class Entry < ActiveRecord::Base
  attr_accessible :content, :link, :published, :title, :photo_id

  belongs_to :feed

  validates_presence_of :content
  validates_uniqueness_of :content
  
  default_scope order('published DESC')

  before_save :set_photo_id

  def set_photo_id
    # http://farm9.staticflickr.com/8103/8476326710_f3a42343da_o.jpg

    begin
      parsed = URI::parse(content)

      return if !parsed.host.ends_with?("flickr.com")

      path_parts = parsed.path.split('/')
      self.photo_id = path_parts[2].split("_")[0]
    rescue
      logger.error "Entry ID #{id} could not be parsed"
    end
  end
end
