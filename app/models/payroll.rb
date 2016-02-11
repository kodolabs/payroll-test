class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  # returns new Payroll with preset dates according to the last saved one and config
  def new_with_dates

  end

  # returns true if last saved Payroll is in the past
  def time_for_a_new_one

  end

  private
  def next_date(date)

  end

  def prev_date(date)

  end
end
