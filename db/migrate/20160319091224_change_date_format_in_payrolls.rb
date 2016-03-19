class ChangeDateFormatInPayrolls < ActiveRecord::Migration
  def change
    change_column :payrolls, :starts_at, :date
    change_column :payrolls, :ends_at, :date
  end
end
