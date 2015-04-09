class Day < ActiveRecord::Base
  has_many :daily_totals
  has_many :share_prices
  has_many :companies, :through => :daily_totals
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
end
