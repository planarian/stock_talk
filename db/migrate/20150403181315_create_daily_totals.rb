class CreateDailyTotals < ActiveRecord::Migration
  def change
    create_table :daily_totals do |t|
      t.integer :count, null: false
      t.datetime :time, null: false
      t.integer :company_id, null: false
    end
  end
end
