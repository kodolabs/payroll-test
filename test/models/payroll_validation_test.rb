require 'test_helper'

class PayrollValidationTest < ActiveSupport::TestCase
  test 'presence starts_at' do
    payroll = create(:payroll)
    payroll.starts_at = nil
    assert_not payroll.valid?
  end

  test 'presence ends_at' do
    payroll = create(:payroll)
    payroll.ends_at = nil
    assert_not payroll.valid?
  end

  test 'starts_at cannot be after ends_at' do
    payroll = create(:payroll)
    payroll.starts_at = DateTime.now
    payroll.ends_at = DateTime.now - 1.week
    assert_not payroll.valid?
  end

  test 'all is ok' do
    payroll = create(:payroll)
    payroll.starts_at = DateTime.now
    payroll.ends_at = DateTime.now + 1.day
    assert payroll.valid?
  end
end