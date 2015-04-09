module RetrieveTweets
  MAX_COUNT = 100
  
  def self.get(company)
    print "Downloading tweets for #{name}..."
    qty = store(company, ask(company))
    print "done. #{qty} tweet(s) retrieved.\n" if qty
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
    unless company.most_recent_tweet.nil?
      min_id = company.most_recent_tweet
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
    company.update(most_recent_tweet: results.first[:id]) if results && !results.count.zero?
    results
  end

  def self.store(company, results)
    qty = results.count if results
    increment = qty ? qty : 0
    today = Day.find_by(date: Time.now.to_date)
    running_total = DailyTotal.find_by(day_id: today, company_id: company)
    
    if running_total
      running_total.update(count: running_total.count + increment)
    else
      running_total = DailyTotal.create!(day_id: today.id, company_id: company.id, count: increment)
      #Why doesn't 'day_id: today' work here?
    end
    if qty.nil?
      running_total.update(error: true)
      company.most_recent_tweet = nil
    end
    qty
  end

end