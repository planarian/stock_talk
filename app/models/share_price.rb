class SharePrice < ActiveRecord::Base
  belongs_to :company
  belongs_to :day

  validates :error, exclusion: { in: [nil] }
  validates :day_id, :company_id, presence: true

  def price
    p = read_attribute(:price)
    p ? p.to_f.round(2) : nil
  end
end
