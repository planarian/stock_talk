class DailyTotal < ActiveRecord::Base
  belongs_to :company
  belongs_to :day

  validates :count, :time, :company_id, presence: true
end
