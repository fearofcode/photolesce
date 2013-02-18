desc 'Update all feeds'
task update_feeds: :environment do
  Feed.find_each do |feed|
    puts "Updating feed with URL #{feed.url}"
    feed.fetch_and_parse
  end
end

desc 'Update all tags'
task update_tags: :environment do
  TumblrTag.find_each do |tag|
    puts "Updating tag #{tag.tag}"
    tag.fetch_and_parse
  end
end

desc 'Fetch or update Flickr favorite counts for the N most recently published entries'
task fetch_flickr_favorites: :environment do
  limit = 2500

  Entry.limit(limit).each_with_index do |entry, i|
    puts "#{Time.now}\tFetching favorite counts for entry #{i+1}"
    entry.fetch_favorite_count
    entry.save
  end
end


desc 'Fetch all data needed for display'
task fetch_all: [:update_feeds, :update_tags, :fetch_flickr_favorites] do
end
