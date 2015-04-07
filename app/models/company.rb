class Company < ActiveRecord::Base
  has_many :daily_totals
  has_many :days, :through => :daily_totals
  has_many :queries

  validates :name, presence: true


  def consolidate
    begin_today = Time.now.midnight
    end_today = Time.now.midnight + 1.day
    total = queries.where(time: begin_today..end_today).inject(0) {|fst, snd| fst + snd[:count]}
    daily_totals.create(count: total, time: Time.now)
    queries.where(time: begin_today..end_today).destroy_all
  end
end
