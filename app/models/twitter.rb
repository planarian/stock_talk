require 'csv'

module RetrieveTweets
  
  def self.get(company)
    store(company, ask(company))
  end

  private

  def self.ask(company)
      unless company.queries.count.zero?
        return Client.search(company.name, since_id: 584739789141839872)
      else 
        return Client.search(company.name)
      end
  end

  def self.store(company, results)
    qty = results.attrs[:statuses].count
    puts "\nbegin: #{results.attrs[:statuses].last[:id]}\nend: #{results.attrs[:statuses].first[:id]}\n" unless qty.zero?
    company.queries.create(time: Time.now,
                           count: qty,
                           earliest_tweet: results.attrs[:statuses].last[:id],
                           most_recent_tweet: results.attrs[:statuses].first[:id]) unless qty.zero?
    qty
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