class Day < ActiveRecord::Base
  has_many :daily_totals
  has_many :share_prices
  has_many :companies, :through => :daily_totals
  validates :date, presence: true
end
