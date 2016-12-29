require 'test_helper'

class PayrollCreateServiceTest < ActiveSupport::TestCase
  setup do
    Utils::Schedule.stubs(:schedule_days).returns([6, 28])
    @service = Services::PayrollCreate.new
  end

  test 'consistency for first payroll' do
    Payroll.stubs(:last_ends_at).returns('1994-07-12'.to_datetime)
    payroll = @service.create_new_payroll
    assert_equal payroll.starts_at, '1994-07-13'.to_datetime
    assert_equal payroll.ends_at, '1994-07-27'.to_datetime
  end

  test 'consistency for some payrolls' do
    payroll_1 = create(:payroll, starts_at: '1994-07-06'.to_datetime, ends_at: '1994-07-27')
    payroll_2 = @service.create_new_payroll
    payroll_3 = @service.create_new_payroll

    assert_equal payroll_2.starts_at, '1994-07-28'.to_datetime
    assert_equal payroll_2.ends_at, '1994-08-05'.to_datetime

    assert_equal payroll_3.starts_at, '1994-08-06'.to_datetime
    assert_equal payroll_3.ends_at, '1994-08-27'.to_datetime
  end
end