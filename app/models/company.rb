class Company < ActiveRecord::Base
  has_many :daily_totals
  has_many :share_prices
  has_many :days, :through => :daily_totals

  validates :name, :symbol, presence: true

  def search_str
    str = name
    str.insert(0, "\"").insert(-1, "\"") if str =~ / /
    str
  end
  
  def self.list_yahoo_format
    out = ""
    all.each { |company| out << "\"#{company.symbol}\"," }
    out.chop
  end


end
