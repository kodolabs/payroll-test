class Payroll::CreateNext
  attr_reader :days

  def initialize(days: Payroll::PAYMENT_DAYS)
    @days = days.sort.freeze
  end

  def call
    last_payroll_end_date = Payroll.maximum(:ends_at) || Date.new(2016, 1, 4)
    start_date = last_payroll_end_date + 1.day
    Payroll.create!(
      starts_at: start_date,
      ends_at: next_payroll_date(since_date: start_date) - 1.day
    )
  end

  private

  def next_payroll_date(since_date:)
    base_date = since_date.clone
    next_payroll_day = days.find{|v| v > base_date.day } || days.first
    base_date += 1.month if base_date.day >= days.last
    base_date.change(day: next_payroll_day)
  end
end
