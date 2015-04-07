class Day < ActiveRecord::Base
  has_many :daily_totals
  has_many :companies, :through => :daily_totals
  validates :date, presence: true
end
