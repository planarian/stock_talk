class CreateDailyTotals < ActiveRecord::Migration
  def change
    create_table :daily_totals do |t|
      t.integer :count, null: false
      t.boolean :error, default: false, null: false
      t.integer :company_id, null: false
      t.integer :day_id, null: false
      t.timestamps
    end
  end
end
