module RetrieveTweets
  
  def self.get(company)
    store(company, ask(company))
  end

  private

  def self.ask(company)
      unless company.queries.count.zero?
        return Client.search(company.name, since_id: company.queries.last.most_recent_tweet.to_i)
      else 
        return Client.search(company.name)
      end
  end

  def self.store(company, results)
    puts "\nbegin: #{results.attrs[:statuses].last[:id]}"
    puts "end: #{results.attrs[:statuses].first[:id]}"
    qty = results.attrs[:statuses].count
    company.queries.create(time: Time.now,
                           count: qty,
                           earliest_tweet: results.attrs[:statuses].last[:id],
                           most_recent_tweet: results.attrs[:statuses].first[:id]) unless qty.zero?
    qty
  end
end