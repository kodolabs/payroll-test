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
      elsif today.day < Payroll::SECOND_HALF_STARTS_AT
        today.change(day: Payroll::SECOND_HALF_STARTS_AT)
      else
        (today + 1.month).change(day: Payroll::FIRST_HALF_STARTS_AT)
      end
    end

    def ends_at
      if starts_at.day == Payroll::FIRST_HALF_STARTS_AT
        starts_at.change(day: Payroll::SECOND_HALF_STARTS_AT - 1)
      else
        (starts_at + 1.month).change(day: Payroll::FIRST_HALF_STARTS_AT - 1)
      end
    end

    def today
      @today ||= Date.today
    end

    def last_payroll
      @last_payroll ||= Payroll.ordered.last
    end
  end
end
