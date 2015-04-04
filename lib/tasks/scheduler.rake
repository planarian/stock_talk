require "#{Rails.root}/app/models/twitter"

desc "This task is called by the Heroku scheduler add-on"
task :query_twitter => :environment do
  loop do
    qty = 0
    Company.all.each do |company|
      print "Downloading tweets for #{company.name}..."
      qty = RetrieveTweets.get(company)
      print "done. #{qty} tweet(s) retrieved.\n"
    end
    break if qty < 100
  end
end

desc "This task is called by the Heroku scheduler add-on"
task :consolidate => :environment do
  Company.all.each do |company|
    print "Consolidating totals for #{company.name}..."
    company.consolidate
    print "done"
  end 
end

# search_results = client.search('Walmart', {since_id: 1234567890})
# last_id = search_results.attrs[:search_metadata][:max_id]
# count = search_results.attrs[:search_metadata][:count]

# first_tweet = search_results.attrs[:statuses].first
# tweet_id = first_tweet[:id]
# tweet_timestamp = Time.parse(first_tweet[:created_at])
# tweet_text = first_tweet[:text]