desc 'Update all feeds'
task update_feeds: :environment do
  Feed.find_each do |feed|
    puts "Updating feed with URL #{feed.url}"
    feed.fetch_and_parse
    sleep 5
  end
end

desc 'Fetch or update Flickr favorite counts for the N most recently published entries'
task fetch_flickr_favorites: :environment do
  limit = 2500

  i = 1

  Entry.limit(limit).each do |entry|
    puts "#{Time.now}\tFetching favorite counts for entry #{i}"
    entry.fetch_favorite_count
    entry.save
    
    i += 1

    sleep 1
  end
end
