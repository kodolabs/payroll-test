class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  START_DATES = [5, 20]

  def self.create(attributes = nil, &block)
    if count == 0
      super(first_payroll_parameters, &block)
    end
  end

  def self.first_payroll_parameters
    start_day = START_DATES.first
    end_day   = START_DATES.last - 1

    starts_at = DateTime.current.beginning_of_year.change(day: start_day)
    ends_at   = DateTime.current.beginning_of_year.change(day: end_day)

    { starts_at: starts_at, ends_at: ends_at }
  end
end
