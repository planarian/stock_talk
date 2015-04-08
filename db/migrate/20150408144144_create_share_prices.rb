class CreateSharePrices < ActiveRecord::Migration
  def change
    create_table :share_prices do |t|
      t.decimal :price
      t.boolean :error, default: false, null: false
      t.integer :day_id, null: false
      t.integer :company_id, null: false
      
      t.timestamps null: false
    end
  end
end
