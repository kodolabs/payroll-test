class PayrollValidationTest < ActiveSupport::TestCase
  setup do
    @some_date = DateTime.now
    DateTime.stubs(:now).returns(@some_date)
  end

  test 'last_ends_at with no payrolls exists' do
    Payroll.delete_all
    assert_equal @some_date, Payroll.last_ends_at
  end

  test 'last_ends_at with some payrolls exists' do
    create(:payroll, starts_at: '1994-07-12'.to_datetime, ends_at: '1994-07-15'.to_datetime)
    create(:payroll, starts_at: '1994-07-16'.to_datetime, ends_at: '1994-07-25'.to_datetime)
    assert_equal '1994-07-25'.to_datetime, Payroll.last_ends_at
  end

end