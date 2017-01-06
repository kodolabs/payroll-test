require 'test_helper'

class ScheduleIntervalsTest < ActiveSupport::TestCase

  test 'next interval start without payrolls' do
    DateTime.stubs(:now).returns('2016-07-10'.to_datetime)
    Utils::Schedule.stubs(:schedule_days).returns([6, 28])
    next_starts_at = Utils::Schedule.next_interval_start
    assert_equal '2016-07-11'.to_datetime, next_starts_at
  end

  test 'next interval start with payrolls' do
    Utils::Schedule.stubs(:schedule_days).returns([2, 12])
    create(:payroll, starts_at: '2016-07-02'.to_datetime, ends_at: '2016-07-11'.to_datetime)
    next_starts_at = Utils::Schedule.next_interval_start
    assert_equal '2016-07-12'.to_datetime, next_starts_at
  end

  test 'next interval end without payrolls' do
    DateTime.stubs(:now).returns('2016-07-10'.to_datetime)
    Utils::Schedule.stubs(:schedule_days).returns([6, 28])
    next_ends_at = Utils::Schedule.next_interval_end
    assert_equal '2016-07-27'.to_datetime, next_ends_at
  end

  test 'next interval end with payrolls' do
    Utils::Schedule.stubs(:schedule_days).returns([2, 12])
    create(:payroll, starts_at: '2016-07-02'.to_datetime, ends_at: '2016-07-11'.to_datetime)
    next_ends_at = Utils::Schedule.next_interval_end
    assert_equal '2016-08-01'.to_datetime, next_ends_at
  end

end
