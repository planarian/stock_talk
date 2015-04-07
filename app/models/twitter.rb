require "#{Rails.root}/lib/to_csv"

module RetrieveTweets
  
  def self.get(company, *start_id)
    print "Downloading tweets for #{name}..."
    qty = store(company, ask(company, start_id))
    print "done. #{qty} tweet(s) retrieved.\n"
    ToCSV.convert(Tweet, "tweet.csv")
  end

  def self.ask(company, *start_id)
    unless company.queries.empty?
      begin_id = start_id.flatten.empty? ? company.queries.last.most_recent_tweet : start_id.flatten[0]
      results = Client.search(company.name, {count: 100, since_id: begin_id}).attrs[:statuses]
    else
      if start_id.flatten.empty?
        results = Client.search(company.name, count: 100).attrs[:statuses]
      else 
        begin_id = start_id.flatten[0]
        results = Client.search(company.name, {count: 100, since_id: begin_id}).attrs[:statuses]
      end
    end
    
    if begin_id && results.count == 100
      loop do 
        interm_results = Client.search(company.name, 
          {count: 100, max_id: results.last[:id] - 1, since_id: begin_id}).attrs[:statuses]
        puts "boundary: #{results.last[:id]}"
        results += interm_results
        puts "#{interm_results.count} added. #{results.count} total."
        break if interm_results.count < 100
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