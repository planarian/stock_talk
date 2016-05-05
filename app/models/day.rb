class Day < ActiveRecord::Base
  has_many :daily_totals, :dependent => :destroy
  has_many :share_prices, :dependent => :destroy
  has_many :companies, :through => :daily_totals
  #rename above to :companies_with_tweets
  has_many :companies_with_shares, :through => :share_prices, :source => :company
  validates :date, presence: true

  def self.add(num_days, offset = 0)
    unless last.nil?
      last_day = last.date
    else
      last_day = create!(date: Date.today - 1).date
      offset = 1
    end
      (1..(num_days - offset)).each { |i| create!(date: last_day + i) }
  end

  def self.subtract(num_days)
    all[0..num_days - 1].each{|d| d.destroy}
  end
end
