class Entry < ActiveRecord::Base
  attr_accessible :content, :link, :published, :title

  belongs_to :feed

  validates_presence_of :content
  validates_uniqueness_of :content
  
  default_scope order('published DESC')
end
