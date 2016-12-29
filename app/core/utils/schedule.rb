class Utils::Schedule
  SCHEDULE_DAYS = [5, 20].sort.freeze

  def self.next_scheduled_date_inclusive(from)
    diffs = schedule_days.map {|schedule_day| schedule_day - from.day}
    positive_diff = diffs.find {|diff| diff >= 0}
    return next_first_date_of_next_month(from) if positive_diff.nil? #min
    return schedule_date_of_this_month(schedule_days[diffs.index(positive_diff)], from)
  end

  def self.schedule_date_of_this_month(day, from)
    from.change(day: day)
  end

  def self.next_scheduled_date_exclusive(from)
    next_scheduled_date_inclusive(from) - 1.day
  end

  def self.schedule_days
    SCHEDULE_DAYS
  end

  private
  def self.next_first_date_of_next_month(from)
    from.change(day: schedule_days.first) + 1.month
  end
end