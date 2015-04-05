class Query < ActiveRecord::Base
  belongs_to :company
  has_many :tweets

  validates :most_recent_tweet, :earliest_tweet, :count, :time, :company_id, presence: true
end
