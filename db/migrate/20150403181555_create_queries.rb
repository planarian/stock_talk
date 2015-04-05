class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.decimal :earliest_tweet, null: false
      t.decimal :most_recent_tweet, null: false
      t.integer :count, null: false
      t.datetime :time, null: false
      t.integer :company_id, null: false
    end
  end
end
