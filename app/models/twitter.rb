require "#{Rails.root}/lib/to_csv"

module RetrieveTweets
  MAX_COUNT = 100
  
  def self.get(company)
    print "Downloading tweets for #{name}..."
    qty = store(company, ask(company))
    print "done. #{qty} tweet(s) retrieved.\n" if qty
    # ToCSV.convert(Tweet, "tweet.csv")  FOR DEBUGGING
  end

  def self.error_handler
    begin
      results = yield
    rescue Twitter::Error => e
        print "TWITTER SEARCH FAILED: #{e.message}"
    end
    results
  end

  def self.ask(company)
    unless company.queries.empty?
      min_id = company.queries.last.most_recent_tweet
      results = error_handler { Client.search(company.name, {count: MAX_COUNT, since_id: min_id}).attrs[:statuses] }
    else
      results = error_handler { Client.search(company.name, count: MAX_COUNT).attrs[:statuses] }
    end
    
    if min_id && results && results.count == MAX_COUNT
      loop do 
        interm_results = error_handler do 
          Client.search(company.name, {count: MAX_COUNT, max_id: results.last[:id] - 1, 
            since_id: min_id}).attrs[:statuses]
        end
        results += interm_results
        puts "#{interm_results.count} added. #{results.count} total."
        break if interm_results.count < MAX_COUNT
      end
    end
    results
  end

  def self.store(company, results)
    qty = results.count if results
    unless qty.nil? || qty.zero?
      query = company.queries.create(
                 time: Time.now,
                 count: qty,
                 earliest_tweet: results.last[:id],
                 most_recent_tweet: results.first[:id])
      # store_tweets(query, results)  FOR DEBUGGING
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