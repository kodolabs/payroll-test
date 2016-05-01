module PayrollCreateHelper
  extend ActiveSupport::Concern

  module ClassMethods
    def first_payroll_parameters
      start_day = Payroll::START_DATES.first
      end_day   = Payroll::START_DATES.last - 1

      starts_at = DateTime.current.beginning_of_year.change(day: start_day)
      ends_at   = DateTime.current.beginning_of_year.change(day: end_day)

      { starts_at: starts_at, ends_at: ends_at }
    end

    def payroll_parameters
      last_payroll = Payroll.ordered.last

      starts_at = last_payroll.ends_at + 1.day
      ends_at   = get_end_date(starts_at)

      { starts_at: starts_at, ends_at: ends_at }
    end

    def get_end_date(start_day)
      next_start_day = start_day.dup

      first_greater = Payroll::START_DATES.find { |day| day > start_day.day }

      next_start_day =
        if first_greater.nil?
          next_start_day.advance(months: 1).change(day: Payroll::START_DATES.first)
        else
          next_start_day.change(day: first_greater)
        end

      next_start_day - 1.day
    end

    def exists_for_date?(date)
      next_payroll_attributes =
        if Payroll.count > 0
          payroll_parameters
        else
          first_payroll_parameters
        end

      next_start = next_payroll_attributes[:starts_at]
      next_end   = next_payroll_attributes[:ends_at]

      date.between?(next_start, next_end)
    end

    def auto_create
      unless exists_for_date?(DateTime.current)
        Payroll.create
      end
    end
  end
end