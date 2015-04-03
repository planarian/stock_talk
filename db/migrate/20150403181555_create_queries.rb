class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.last_tweet :int, null: false
      t.count :int, null: false
      t.time :datetime, null: false
      t.company_id :int, null: false
    end
  end
end
