class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.integer :last_tweet, null: false
      t.integer :count, null: false
      t.datetime :time, null: false
      t.integer :company_id, null: false
    end
  end
end
