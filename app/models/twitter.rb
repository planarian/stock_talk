module RetrieveTweets
  
  def self.get(company)
    store(company, ask(company))
  end

  private

  def self.ask(company)
      unless company.queries.count.zero?
        return Client.search(company.name, since_id: company.queries.last.last_tweet.to_i)
      else 
        return Client.search(company.name)
      end
  end

  def self.store(company, results)
    qty = results.attrs[:statuses].count
    company.queries.create(time: Time.now,
                           count: qty,
                           last_tweet: results.attrs[:search_metadata][:max_id])
    qty
  end
end