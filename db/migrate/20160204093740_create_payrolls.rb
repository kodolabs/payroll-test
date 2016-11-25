class CreatePayrolls < ActiveRecord::Migration
  def change
    create_table :payrolls do |t|
      t.date :starts_at
      t.date :ends_at
      t.timestamps null: false
    end
  end
end
