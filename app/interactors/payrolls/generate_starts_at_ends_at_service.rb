module Payrolls
  class GenerateStartsAtEndsAtService
    include Interactor

    def call
      context.starts_at = starts_at
      context.ends_at = ends_at
    end

    private

    def last_payroll
      Payroll.ordered.last
    end

    def starts_at
      if last_payroll.present?
        if last_payroll.first_half?
          last_payroll.starts_at.change(day: Payroll::SECOND_HALF_STARTS_AT)
        else
          (last_payroll.starts_at + 1.month).change(day: Payroll::FIRST_HALF_STARTS_AT)
        end
      else
        if today.day < 15
          today.change(day: Payroll::SECOND_HALF_STARTS_AT)
        else
          (today + 1.month).change(day: Payroll::FIRST_HALF_STARTS_AT)
        end
      end
    end

    def ends_at
      if starts_at.day == Payroll::FIRST_HALF_STARTS_AT
        starts_at.change(day: Payroll::SECOND_HALF_STARTS_AT - 1)
      else
        (starts_at + 1.month).change(day: Payroll::SECOND_HALF_STARTS_AT - 1)
      end
    end

    def today
      @today ||= Date.today
    end
  end
end
