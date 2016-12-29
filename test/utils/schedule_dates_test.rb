class ScheduleDatesTest < ActiveSupport::TestCase
  test 'nearest next date inclusive' do
    Utils::Schedule.stubs(:schedule_days).returns([6, 28])
    assert_equal Utils::Schedule.next_scheduled_date_inclusive('1994-12-29'.to_datetime), '1995-01-06'.to_datetime
    assert_equal Utils::Schedule.next_scheduled_date_inclusive('1994-07-01'.to_datetime), '1994-07-06'.to_datetime
    assert_equal Utils::Schedule.next_scheduled_date_inclusive('1994-07-28'.to_datetime), '1994-07-28'.to_datetime
  end

  test 'nearest next date exclusive' do
    Utils::Schedule.stubs(:schedule_days).returns([6, 28])
    assert_equal Utils::Schedule.next_scheduled_date_exclusive('1994-12-28'.to_datetime), '1994-12-27'.to_datetime
    assert_equal Utils::Schedule.next_scheduled_date_exclusive('1994-07-07'.to_datetime), '1994-07-27'.to_datetime
    assert_equal Utils::Schedule.next_scheduled_date_exclusive('1994-07-28'.to_datetime), '1994-07-27'.to_datetime
  end
end