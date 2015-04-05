class Query < ActiveRecord::Base
  belongs_to :company

  validates :most_recent_tweet, :earliest_tweet, :count, :time, :company_id, presence: true
end
