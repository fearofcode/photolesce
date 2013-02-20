module EntryHelper
  def source_str(entry)
    if entry.tumblr_tag
      "from Tumblr tag #{entry.tumblr_tag.tag}"
    elsif entry.feed && entry.feed.title
      "'#{entry.title}', from Flickr feed '#{entry.feed.title}'"
    else
      ""
    end
  end
end
