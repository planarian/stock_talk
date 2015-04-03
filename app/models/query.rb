class Query < ActiveRecord::Base
  belongs_to :company

  validates :last_tweet, :count, :time, :company_id, presence: true
end
