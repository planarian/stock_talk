class DailyTotal < ActiveRecord::Base
  belongs_to :company
  belongs_to :day

  validates :count, :day_id, :company_id, presence: true
end
