class Tweet < ActiveRecord::Base
  belongs_to :Query
  validates :number, :text, :time, :query_id, presence: true
end
