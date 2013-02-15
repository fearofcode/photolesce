desc 'Update all feeds'
task update_feeds: :environment do
  Feed.all.each do |feed|
    puts "Updating feed with URL #{feed.url}"
    feed.fetch_and_parse
    sleep 5
  end
end
