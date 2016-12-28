module Payrolls
  class CreatePayrollService
    include Interactor

    before do
      @starts_at = context.starts_at || (raise ArgumentError)
      @ends_at   = context.ends_at || (raise ArgumentError)
    end

    def call
      validate_params
      Payroll.create(starts_at: starts_at, ends_at: ends_at)
    end

    private

    attr_reader :starts_at, :ends_at

    def validate_params
      raise ArgumentError, 'starts_at is not a Date' unless starts_at.is_a?(Date)
      raise ArgumentError, 'ends_at is not a Date' unless ends_at.is_a?(Date)
    end
  end
end
