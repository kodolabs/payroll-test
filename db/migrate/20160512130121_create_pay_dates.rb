class CreatePayDates < ActiveRecord::Migration
  def change
    create_table :pay_dates do |t|
      t.integer :pay_date
      t.boolean :is_first
      t.boolean :is_last
    end
  end
end
