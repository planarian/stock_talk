class Tweet < ActiveRecord::Base
  belongs_to :query
  validates :number, :text, :time, :query_id, presence: true

  def to_a
    [id, number.to_i.to_s, text, time, query.company.name]
  end


end
