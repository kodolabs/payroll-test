class PayrollService

  # Default periods need to extract to different tables in db
  # And add model for management.
  DEFAULT_PERIODS = {
    5 => 19,
    20 => 4
  }

  attr_reader :start_date, :end_date

  def initialize
    @start_date = start_date
    @end_date = end_date
  end

  def generate
    Payroll.new(starts_at: start_date, ends_at: end_date)
  end

  private

  def last_payroll
    @last_payroll ||= Payroll.last
  end

  def last_end_date
    @date ||= (last_payroll ? last_payroll.ends_at : nil)
  end

  def first_date
    today_date = Date.today.day

    DEFAULT_PERIODS.each do |start_period, _|
      if today_date <= start_period
        days_to_start_period = start_period - today_date
        return Date.today + days_to_start_period
      end
    end
  end

  def start_date
    new_start_date = last_end_date ? last_end_date + 1.day : first_date
    @start_date ||= if DEFAULT_PERIODS[new_start_date.day]
                      new_start_date
                    else
                      correct_start_date(new_start_date)
                    end

  end

  def correct_start_date(start_payroll)
    next_day_from_range = find_day_number_after_last_ends_at(start_payroll)

    if next_day_from_range.nil?
      get_date_by_first_range(start_payroll)
    else
      get_date_from_range_after_last_ends_at(start_payroll, next_day_from_range)
    end
  end

  def get_date_by_first_range(start_day)
    find_next_day = DEFAULT_PERIODS.keys[0]
    start_day.end_of_month + find_next_day.days
  end

  def find_day_number_after_last_ends_at(starts_at)
    DEFAULT_PERIODS.select{|day| day > starts_at.day}.keys[0]
  end

  def get_date_from_range_after_last_ends_at(starts_at, next_day_from_range)
    starts_at + (next_day_from_range - starts_at.day).days
  end

  def end_date
    first_day = start_date.day
    #byebug
    if DEFAULT_PERIODS[first_day] > first_day
      @end_date ||= start_date + (DEFAULT_PERIODS[first_day] - first_day).days
    else
      @end_date ||= start_date.end_of_month + DEFAULT_PERIODS[first_day].days
    end
  end
end
