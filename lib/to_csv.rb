require 'csv'


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