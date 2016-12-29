require 'test_helper'

class PayrollAutoCreateServiceTest < ActiveSupport::TestCase
  setup do
    Payroll.delete_all
    @service = Services::PayrollAutoCreate.new
    create(:payroll, starts_at: '2016-07-02'.to_datetime, ends_at: '2016-07-11'.to_datetime)
  end

  test 'executes in right time' do
    DateTime.stubs(:now).returns('2016-07-12')
    @service.process
    assert_equal Payroll.count, 2
  end

  test 'dont executes when no need' do
    DateTime.stubs(:now).returns('2016-07-10'.to_datetime)
    @service.process
    assert_equal Payroll.count, 1
  end
end
