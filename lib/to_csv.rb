require 'csv'


module ToCSV
  def self.convert(model, filename)
    CSV.open(filename, "wb") do |csv|
      csv << model.attribute_names
      model.all.each do |item| 
        csv << item.to_a
      end
    end
  end
end