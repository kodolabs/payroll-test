class CreatePayrollDays < ActiveRecord::Migration
  def change
    create_table :payroll_days do |t|
      t.integer :day

      t.timestamps null: false
    end
  end
end
