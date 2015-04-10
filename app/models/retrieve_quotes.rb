module RetrieveQuotes
  Date.send(:include, CoreExtensions::Date::Yahoo)

  def self.get_yesterday
    get(Date.today - 1)
  end

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
      parsed  = JSON.parse(from_server.body)
      unless parsed[:error]
        market_open = !!parsed["query"]["results"]
        results = market_open ? parsed["query"]["results"]["quote"] : :closed
      end
    end
    results
  end

  def self.store(day_of)
    results = ask(day_of)
    Company.all.order(:id => :asc).each_with_index do |company, i|
      init = {company_id: company.id, day_id: day_of.id}
      # Why not 'company_id: company, day_id: day_of'?
      if results.instance_of?(Array)
        init.merge!(price: results[i]["Close"].to_d, error: false)  
      elsif results.nil?
        init.merge!(error: true)
      end
      
      existing_record = SharePrice.find_by(company_id: company, day_id: day_of)
      unless existing_record
        SharePrice.create!(init)
      else
        existing_record.update(init)
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
