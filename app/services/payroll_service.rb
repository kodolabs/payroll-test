class PayrollService

  # Default periods need to extract to different tables in db
  # And add model for management.
  DEFAULT_STARTS_DAYS = [5, 20]

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

  def today
    @today ||= Date.today
  end

  def start_date
    @start_date ||= last_end_date ? next_starts_at : first_date(today)
  end

  def first_date(current_day)
    if start_day_in_current_month(current_day)
      current_day + (start_day_in_current_month(current_day) - current_day.day).days
    else
      get_date_by_first_range(current_day)
    end
  end

  def next_starts_at
    next_date = (last_end_date - 1.day)

    DEFAULT_STARTS_DAYS.include?(next_date.day) ? next_date : first_date(next_date)
  end

  def start_day_in_current_month(current_date)
    @next_day ||= DEFAULT_STARTS_DAYS.select{|day| day >= current_date.day }.first
  end

  def get_date_by_first_range(start_day)
    start_day.end_of_month + DEFAULT_STARTS_DAYS.first.days
  end

  def get_date_from_range_after_last_ends_at(starts_at, next_day_from_range)
    starts_at + (next_day_from_range - starts_at.day).days
  end

  def end_date
    next_day_in_month = DEFAULT_STARTS_DAYS.select{|day| day > start_date.day }.first

    if next_day_in_month
      @end_date ||= start_date + (next_day_in_month - 1 - start_date.day).days
    else
      @end_date ||= start_date.end_of_month + (DEFAULT_STARTS_DAYS.first - 1).days
    end
  end
end
