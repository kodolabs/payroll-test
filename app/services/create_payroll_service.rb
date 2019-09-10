class CreatePayrollService
  include Command

  def initialize(payrolls_collection: Payroll, dates_calculator: PayrollDatesCalculator)
    @payrolls_collection = payrolls_collection
    @dates_calculator = dates_calculator
  end

  def call
    payroll_period = dates_calculator.call(
      last_payroll_date: payrolls_collection.last.try!(:ends_at)
    )
    Payroll.create(starts_at: payroll_period.starts_at, ends_at: payroll_period.ends_at)
  end

  private

  attr_reader :dates_calculator, :payrolls_collection
end
