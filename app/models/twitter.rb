require "#{Rails.root}/lib/to_csv"

module RetrieveTweets
  MAX_COUNT = 100
  
  def self.get(company)
    print "Downloading tweets for #{name}..."
    qty = store(company, ask(company))
    print "done. #{qty} tweet(s) retrieved.\n"
    ToCSV.convert(Tweet, "tweet.csv")
  end

  def self.ask(company)
    unless company.queries.empty?
      min_id = company.queries.last.most_recent_tweet
      results = Client.search(company.name, {count: MAX_COUNT, since_id: min_id}).attrs[:statuses]
    else
      results = Client.search(company.name, count: MAX_COUNT).attrs[:statuses]
    end
    
    if min_id && results.count == MAX_COUNT
      loop do 
        interm_results = Client.search(company.name, 
          {count: MAX_COUNT, max_id: results.last[:id] - 1, since_id: min_id}).attrs[:statuses]
        results += interm_results
        puts "#{interm_results.count} added. #{results.count} total."
        break if interm_results.count < MAX_COUNT
      end
    end
    results
  end

  def self.store(company, results)
    qty = results.count
    unless qty.zero?
      query = company.queries.create(
                 time: Time.now,
                 count: qty,
                 earliest_tweet: results.last[:id],
                 most_recent_tweet: results.first[:id])
      store_tweets(query, results)
    end
    qty
  end

  def self.store_tweets(query, results)
    results.each do |record|
      query.tweets.create(
        number: record[:id],
        text: record[:text],
        time: record[:created_at])
    end
  end
end