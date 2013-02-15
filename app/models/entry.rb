class Entry < ActiveRecord::Base
  attr_accessible :content, :link, :published

  belongs_to :feed

  validates_presence_of :content
  validates_uniqueness_of :content
end
