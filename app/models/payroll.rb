class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  # returns new Payroll with preset dates according to the last saved one and config
  def self.new_with_dates
    p = new
    last_payroll = Payroll.ordered.last
    if last_payroll
      start = last_payroll.ends_at.advance(days: 1)
      p.starts_at = start
      p.ends_at = next_date(start)
    else
      p.starts_at = prev_date(DateTime.now)
      p.ends_at = next_date(DateTime.now.advance(days: -1))
    end

    p
  end

  # returns true if last saved Payroll is in the past
  def self.time_for_a_new_one
    last_payroll = Payroll.ordered.last
    !last_payroll || last_payroll.ends_at < DateTime.now.at_beginning_of_day
  end

  private
  # only uses strict comparison, if today is one of payroll days - next one will be returned
  def self.next_date(date)
    days = Rails.configuration.payroll_days
    cur_day = date.day
    next_day = days.find {|d| d > cur_day}
    next_day ||= days.first

    if next_day < cur_day
      # next month
      # todo: won't work for strange cases like [29, 30, 31] and Feb, same for prev_date
      date.beginning_of_month.advance(months: 1).change(day: next_day)
    else
      # same month
      begin
        date.change(day: next_day)
      rescue ArgumentError
        date.at_end_of_month.beginning_of_day
      end
    end
  end

  def self.prev_date(date)
    days = Rails.configuration.payroll_days
    cur_day = date.day
    prev_day = days.find {|d| d < cur_day}
    prev_day ||= days.last
    if prev_day > cur_day
      # prev month
      d = date.at_beginning_of_month.advance(months: -1)
      begin
        d = d.change(day: prev_day)
      rescue ArgumentError
        d = d.at_end_of_month.at_beginning_of_day
      end
    else
      # same month
      date.change(day: prev_day)
    end
  end
end
