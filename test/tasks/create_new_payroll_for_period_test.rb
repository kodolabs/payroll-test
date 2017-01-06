require 'test_helper'

class CreateNewPayrollForPeriodTest < ActiveSupport::TestCase
  test 'exec' do
    Services::PayrollAutoCreate.any_instance.expects(:process)
    Rake::Task['cron:create_new_payroll_for_period'].invoke
  end
end