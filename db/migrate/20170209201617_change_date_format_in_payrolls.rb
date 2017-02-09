class ChangeDateFormatInPayrolls < ActiveRecord::Migration
  def up
   change_column :payrolls, :starts_at, :date
   change_column :payrolls, :ends_at, :date
  end

  def down
   change_column :payrolls, :starts_at, :datetime
   change_column :payrolls, :ends_at, :datetime
  end
end
