class PayrollsCreator
  def initialize(payout_date: nil)
    @payout_date = payout_date
  end

  def process
    Payroll.create! starts_at: period.first, ends_at: period.end
  end

  private

  attr_accessor :payout_date

  def period
    date = payout_date || last_payroll&.ends_at&.tomorrow || Date.today
    PeriodBuilder.new(date).range
  end

  def last_payroll
    @last_payroll ||= Payroll.ordered.last
  end
end
