class ChangePayrollDatesType < ActiveRecord::Migration
  def change
    change_column :payrolls, :starts_at, :date, null: false
    change_column :payrolls, :ends_at,   :date, null: false
  end
end
