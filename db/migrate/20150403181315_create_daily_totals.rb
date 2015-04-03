class CreateDailyTotals < ActiveRecord::Migration
  def change
    create_table :daily_totals do |t|
      t.count :int, null: false
      t.time :datetime, null: false
      t.company_id :int, null: false
    end
  end
end
