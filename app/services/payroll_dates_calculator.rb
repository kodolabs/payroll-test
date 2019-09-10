class PayrollDatesCalculator
  include Command

  def initialize(last_payroll_date:, payout_days: Payroll::PAYOUT_DAYS)
    @payout_days = payout_days.sort
    @last_payroll_date = last_payroll_date || Date.today
  end

  def call
    starts_at = next_payout_date(last_payroll_date)
    ends_at = next_payout_date(starts_at) - 1.day
    OpenStruct.new(starts_at: starts_at, ends_at: ends_at)
  end

  def next_payout_date(date)
    day = next_payout_day(date)
    next_date = date.dup.change(day: day)
    return next_date if date.day < day
    next_date + 1.month
  end

  def next_payout_day(date)
    payout_days.find { |day| date.day < day } || payout_days.first
  end

  private

  attr_reader :payout_days, :last_payroll_date
end
