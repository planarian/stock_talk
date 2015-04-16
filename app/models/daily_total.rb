class DailyTotal < ActiveRecord::Base
  belongs_to :company
  belongs_to :day

  validates :count, :day_id, :company_id, presence: true

  def self.csv_header
    "Date, Mentions\n"
  end

  def csv_row
    "#{day.date.yahoo_format}, #{error ? nil : count}\n"
  end
end
