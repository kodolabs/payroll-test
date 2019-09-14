require 'rails_helper'

RSpec.describe PayrollDatesCalculator do
  subject(:calculator) { described_class.new(last_payroll_date: last_payroll_date, payout_days: payout_days) }
  let(:last_payroll_date) { Date.parse('2019-09-10') }
  let(:payout_days) { [5, 20] }

  describe '#call' do
    context 'when there is one payout per month' do
      let(:payout_days) { [20] }

      it 'generates correct dates' do
        expect(calculator.call).to have_attributes(
          starts_at: a_date_matching(Date.parse('2019-09-20')),
          ends_at: a_date_matching(Date.parse('2019-10-19'))
        )
      end
    end

    context 'when payroll starts on last payout day' do
      it 'generates end date that is in next month' do
        expect(calculator.call).to have_attributes(
          starts_at: a_date_matching(Date.parse('2019-09-20')),
          ends_at: a_date_matching(Date.parse('2019-10-04'))
        )
      end
    end

    context 'when payroll starts not on last payout day' do
      let(:last_payroll_date) { Date.parse('2019-09-03') }

      it 'generates end date that is in current month' do
        expect(calculator.call).to have_attributes(
          starts_at: a_date_matching(Date.parse('2019-09-05')),
          ends_at: a_date_matching(Date.parse('2019-09-19'))
        )
      end
    end
  end
end
