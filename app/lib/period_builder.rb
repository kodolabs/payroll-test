class PeriodBuilder
  def initialize(date)
    @date = date
  end

  def range
    @period ||= (period_start..period_end)
  end

  private

  attr_accessor :date

  def period_start
    period = (date - 1.month)..date
    period.select{ |date| payout_days.include?(date.day) }.last.tomorrow
  end

  def period_end
    period = date..date + 1.month
    period.select{ |date| payout_days.include?(date.day) }.first
  end

  def payout_days
    @payout_days ||= PayoutSchedule.pluck(:day_of_month)
  end
end
