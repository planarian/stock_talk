class SharePrice < ActiveRecord::Base
  belongs_to :company
  belongs_to :day

  validates :day_id, :company_id, :error, presence: true
end
