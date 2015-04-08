class Company < ActiveRecord::Base
  has_many :daily_totals
  has_many :days, :through => :daily_totals
  has_many :queries

  validates :name, presence: true


end
