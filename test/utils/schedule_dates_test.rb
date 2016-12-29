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

  test 'bordered days in schedule inclusive' do
    Utils::Schedule.stubs(:schedule_days).returns([6, 31])
    assert_equal Utils::Schedule.next_scheduled_date_inclusive('1994-02-26'.to_datetime), '1994-02-28'.to_datetime
    assert_equal Utils::Schedule.next_scheduled_date_inclusive('1994-04-12'.to_datetime), '1994-04-30'.to_datetime
    assert_equal Utils::Schedule.next_scheduled_date_inclusive('1994-05-28'.to_datetime), '1994-05-31'.to_datetime
  end

  test 'bordered days in schedule exclusive' do
    Utils::Schedule.stubs(:schedule_days).returns([6, 31])
    assert_equal Utils::Schedule.next_scheduled_date_exclusive('1994-02-26'.to_datetime), '1994-02-27'.to_datetime
    assert_equal Utils::Schedule.next_scheduled_date_exclusive('1994-04-12'.to_datetime), '1994-04-29'.to_datetime
    assert_equal Utils::Schedule.next_scheduled_date_exclusive('1994-05-28'.to_datetime), '1994-05-30'.to_datetime
  end

  test 'fix scheduled days' do
    Utils::Schedule.stubs(:schedule_days).returns([6, 28, 29, 30])
    assert_equal Utils::Schedule.fix_schedule_days_for('1994-02-12'.to_datetime), [6, 28, 28, 28]
  end
end