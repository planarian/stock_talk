class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.decimal :number, null: false
      t.string :text, null: false
      t.datetime :time, null: false
      t.integer :query_id, null: false
    end
  end
end
