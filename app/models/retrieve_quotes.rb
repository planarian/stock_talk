module RetrieveQuotes
  Date.send(:include, CoreExtensions::Date::Yahoo)

  def self.get(day)
    day_of = Day.find_by(date: day)
    print "Downloading quotes for #{day_of.date}..."
    results = store(day_of)
    if results
      results == :closed ? puts("Market closed.") : puts("done.")
    else
      puts("YAHOO REQUEST FAILED")
    end
  end


  def self.ask(day_of)
    from_server = Typhoeus.get(prepare_url(day_of.date))
    if from_server.success?
      parsed  = JSON.parse(from_server.body)["query"]["results"]
      results = parsed ? parsed["quote"] : :closed
    end
    results
  end

  def self.store(day_of)
    results = ask(day_of)
    Company.all.each_with_index do |company, i|
      unless SharePrice.find_by(company_id: company, day_id: day_of)
        init = {company_id: company.id, day_id: day_of.id}
        # Why not 'company_id: company, day_id: day_of'?
        if results.respond_to?(:[])
          init.merge!(price: results[i]["Close"].to_d)  
        elsif results.nil?
          init.merge!(error: true)
        end
        SharePrice.create!(init)
      end
    end
    results
  end

  def self.prepare_url(day)
    url = "http://query.yahooapis.com/v1/public/yql?q=select * from"\
    " yahoo.finance.historicaldata where symbol in (#{Company.list_yahoo_format})"\
    " and startDate = \"#{day.yahoo_format}\" and endDate = \"#{day.yahoo_format}"\
    "\"&diagnostics=true&env=store://datatables.org/alltableswithkeys&format=json"
    
    URI.escape(url)
  end

  # private_class_method :ask, :store, :prepare_url

end
