class Company < ActiveRecord::Base
  has_many :daily_totals
  has_many :days, :through => :daily_totals
  has_many :queries

  validates :name, presence: true


  def consolidate
    queries.group_by { |q| q.time.to_date }.each do |key, val|
      curr_day = Day.find_by(date: key)
      new_total = val.inject(0) { |acc, nxt| acc + nxt.count }
      already_stored = daily_totals.find_by(day_id: curr_day)
      if already_stored
        already_stored.update(count: already_stored.count + new_total)
      else
        daily_totals.create!(day_id: curr_day.id, count: new_total)
        #Why doesn't 'day_id: curr_day' work here?
      end
    end
    queries.destroy_all
  end
end
