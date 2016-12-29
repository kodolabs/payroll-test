class Utils::Schedule
  SCHEDULE_DAYS = [5, 20].sort.freeze

  def self.next_scheduled_date_inclusive(from)
    [next_schedule_date_of_this_month(from), next_schedule_date_of_next_month(from)].find{|x| x}
  end

  def self.next_scheduled_date_exclusive(from)
    next_scheduled_date_inclusive(from) - 1.day
  end

  def self.schedule_days
    SCHEDULE_DAYS
  end

  def self.fix_schedule_days_for(date)
    days_in_current_month = date.end_of_month.day
    schedule_days.map {|day| [days_in_current_month, day].min}
  end

  private
  def self.next_schedule_date_of_next_month(from)
    from.change(day: fix_schedule_days_for(from).first) + 1.month
  end

  def self.next_schedule_date_of_this_month(from)
    _, positive_diff_index = fix_schedule_days_for(from)
                                           .map {|schedule_day| schedule_day - from.day}
                                           .each_with_index.find { |diff, index| diff >= 0}
    return nil if positive_diff_index.nil?
    return from.change(day: schedule_days[positive_diff_index])
  end
end