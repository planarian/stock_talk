class DailyTotal < ActiveRecord::Base
  belongs_to :company

  validates :count, :time, :company_id, presence: true
end
