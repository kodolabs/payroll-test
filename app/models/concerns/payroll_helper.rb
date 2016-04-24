module PayrollHelper
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def get_new_payroll_attributes
      Payroll.count == 0 ? start_payroll : standard_payroll
    end

    private

    def start_payroll
      new_year = Time.new.utc.beginning_of_year
      {
        start_at: new_year.change(day: sort_dates.first),
        ends_at:  new_year.end_of_month.day < sort_dates.last - 1 ? new_year.end_of_month : new_year.change(day: sort_dates.last - 1)
      }
    end

    def standard_payroll
      last_payroll_ends_at = Time.parse(Payroll.ordered.last.ends_at.to_s)
      start_at             = last_payroll_ends_at.advance(days: 1)
      sort_dates.first <= last_payroll_ends_at.day ? ends_at = get_ends_date(start_at, sort_dates.first) : ends_at = get_ends_date(start_at, sort_dates.last)
      { start_at: start_at, ends_at: ends_at }
    end

    def get_ends_date(start_at, day)
      if day - 1 < start_at.day
        ends_at   = start_at.next_month.end_of_month if day - 1 > start_at.next_month.end_of_month.day
        ends_at ||= day - 1 > 0 ? start_at.next_month.change(day: day - 1) : start_at.change(day: ends_value_if_start_month(start_at))
      else
        ends_at   = start_at.end_of_month if day - 1 > start_at.end_of_month.day
        ends_at ||= day - 1 > 0 ? start_at.change(day: day - 1) : start_at.change(day: ends_value_if_start_month(start_at))
      end
    end

    def ends_value_if_start_month(start_at)
      return start_at.end_of_month.day if start_at.day == sort_dates.last
      sort_dates.last - 1 <= start_at.end_of_month.day ? sort_dates.last - 1 : start_at.end_of_month.day
    end

    def sort_dates
      @sort_array ||= Payroll::DATE_ARRAY.sort
    end
  end
end