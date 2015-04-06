require 'csv'

module RetrieveTweets
  
  def self.get(company, *start_id)
    print "Downloading tweets for #{name}..."
    store(company, ask(company, start_id))
    print "done. #{qty} tweet(s) retrieved.\n"
    ToCSV.convert(Tweet, "tweet.csv")
  end

  def self.ask(company, *start_id)
    unless company.queries.empty?
      begin_id = start_id.flatten.empty? ? company.queries.last.most_recent_tweet : start_id.flatten[0]
      results = Client.search(company.name, since_id: begin_id).attrs[:statuses]
    else
      if start_id.flatten.empty?
        results = Client.search(company.name).attrs[:statuses]
      else 
        begin_id = start_id.flatten[0]
        results = Client.search(company.name, since_id: begin_id).attrs[:statuses]
        puts "batch 1"
      end
    end
    
    if results.count == 100
      count = 1
      loop do 
        interm_results = Client.search(company.name, 
          {max_id: results.last[:id], since_id: begin_id}).attrs[:statuses]
        results += interm_results
        puts "batch #{count}. #{interm_results.count} added. #{results.count} total."
        break if interm_results.count < 100
      end
    end
    results
  end

  def self.store(company, results)
    qty = results.count
    unless qty.zero?
      puts "\nbegin: #{results.attrs[:statuses].last[:id]}\nend: #{results.attrs[:statuses].first[:id]}\n"  
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
        time: record[:created_at] )
    end
  end
end


module ToCSV
  def self.convert(model, filename)
    CSV.open(filename, "wb") do |csv|
      csv << model.attribute_names
      model.all.each do |item| 
        csv << item.attributes.values.map{ |x| x.instance_of?(BigDecimal) ? x.to_i.to_s : x }
      end
    end
  end

end