require 'csv'

module RetrieveTweets
  
  def self.get(company, *start_id)
    qty = message_wrapper(company.name) { store(company, ask(company, start_id)) }
    qty = message_wrapper(company.name) { store(company, ask(company)) } while qty == 100
    ToCSV.convert(Tweet, "tweet.csv")
  end

  def self.message_wrapper(name)
    print "Downloading tweets for #{name}..."
    qty = yield 
    print "done. #{qty} tweet(s) retrieved.\n"
    qty
  end

  def self.ask(company, *start_id)
      start_id = start_id[0] unless start_id.empty?
      unless company.queries.count.zero?
        return Client.search(
          company.name, since_id: start_id.empty? ? company.queries.last.most_recent_tweet : start_id[0])
      else 
        return start_id.empty? ? Client.search(company.name) : Client.search(company.name, start_id[0])
      end
  end

  def self.store(company, results)
    qty = results.attrs[:statuses].count
    puts "\nbegin: #{results.attrs[:statuses].last[:id]}\nend: #{results.attrs[:statuses].first[:id]}\n" unless qty.zero?
    
    unless qty.zero?
      query = company.queries.create(
                 time: Time.now,
                 count: qty,
                 earliest_tweet: results.attrs[:statuses].last[:id],
                 most_recent_tweet: results.attrs[:statuses].first[:id])
      store_tweets(query, results)
    end
    
    qty
  end

  def self.store_tweets(query, results)
    results.attrs[:statuses].each do |record|
      query.tweets.create(
        number: record[:id],
        text: record[:text],
        time: record[:created_at] )
    end
  end
end


module ToCSV
  def self.convert(model, filename)
    CSV.open("#{filename}", "wb") do |csv|
      csv << model.attribute_names
      model.all.each do |item| 
        csv << item.attributes.values.map{ |x| x.instance_of?(BigDecimal) ? x.to_i.to_s : x }
      end
    end
  end

end