class SharePrice < ActiveRecord::Base
  belongs_to :company
  belongs_to :day

  validates :error, exclusion: { in: [nil] }
  validates :day_id, :company_id, presence: true
end
