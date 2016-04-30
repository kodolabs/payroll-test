class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  START_DATES = [5, 20]

  def self.create(attributes = nil, &block)
    if count == 0
      super(first_payroll_parameters, &block)
    else
      super(payroll_parameters, &block)
    end
  end

  def self.first_payroll_parameters
    start_day = START_DATES.first
    end_day   = START_DATES.last - 1

    starts_at = DateTime.current.beginning_of_year.change(day: start_day)
    ends_at   = DateTime.current.beginning_of_year.change(day: end_day)

    { starts_at: starts_at, ends_at: ends_at }
  end

  def self.payroll_parameters
    last_payroll = ordered.last

    starts_at = last_payroll.ends_at + 1.day
    ends_at   = get_end_date(starts_at)

    { starts_at: starts_at, ends_at: ends_at }
  end

  def self.get_end_date(start_day)
    next_start_day = start_day.dup

    first_greater = START_DATES.find { |day| day > start_day.day }

    next_start_day =
      if first_greater.nil?
        next_start_day.advance(months: 1).change(day: START_DATES.first)
      else
        next_start_day.change(day: first_greater)
      end

    next_start_day - 1.day
  end
end
