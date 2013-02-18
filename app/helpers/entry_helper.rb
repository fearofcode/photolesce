module EntryHelper
  def source_str(entry)
    if entry.tumblr_tag_id
      ", from Tumblr tag #{entry.tumblr_tag.tag} API search"
    elsif entry.feed.title
      ", from Flickr feed '#{entry.feed.title}'"
    else
      ""
    end
  end
end
