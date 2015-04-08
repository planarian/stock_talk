class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.decimal :most_recent_tweet
      t.timestamps null: false
    end
  end
end
