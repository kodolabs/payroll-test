module Payrolls
  class GenerateStartsAtEndsAtService
    include Interactor

    def call
      context.starts_at = starts_at.to_date
      context.ends_at = ends_at.to_date
    end

    private

    def starts_at
      if last_payroll.present?
        last_payroll.ends_at + 1.day
      elsif initial_pay_day
        today.change(day: initial_pay_day)
      else
        (today + 1.month).change(day: pay_days.first)
      end
    end

    def ends_at
      if next_pay_day
        starts_at.change(day: next_pay_day - 1)
      else
        (starts_at + 1.month).change(day: pay_days.first - 1)
      end
    end

    def today
      @today ||= Date.today
    end

    def last_payroll
      @last_payroll ||= Payroll.ordered.last
    end

    def initial_pay_day
      pay_days.select { |d| today.day < d }.first
    end

    def next_pay_day
      pay_days.select { |d| starts_at.day < d }.first
    end

    def pay_days
      Payroll::PAY_DAYS.sort
    end
  end
end
