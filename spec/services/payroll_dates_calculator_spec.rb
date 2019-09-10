require 'rails_helper'

RSpec.describe PayrollDatesCalculator do
  subject(:calculator) { described_class.new(last_payroll_date: last_payroll_date) }
  let(:last_payroll_date) { Date.parse('2019-09-10') }
  let(:payout_days) { [5, 20] }

  describe '#call' do
    it 'generates dates for next payroll' do
      expect(calculator.call).to have_attributes(
        starts_at: a_date_matching(Date.parse('2019-09-20')),
        ends_at: a_date_matching(Date.parse('2019-10-04'))
      )
    end
  end
end
