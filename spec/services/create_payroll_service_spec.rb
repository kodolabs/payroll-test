require 'rails_helper'

RSpec.describe CreatePayrollService do
  subject(:service) do
    described_class.new(payrolls_collection: payrolls, dates_calculator: dates_calculator)
  end
  let(:payrolls) { double(last: double(ends_at: Date.today)) }
  let(:dates_calculator) { double(call: double(starts_at: 1.day.from_now, ends_at: 3.days.from_now))}

  describe '#call' do
    it 'creates payroll' do
      expect { service.call }.to change(Payroll, :count).by(1)
      expect(Payroll.last).to have_attributes(
        starts_at: a_date_matching(1.day.from_now),
        ends_at: a_date_matching(3.days.from_now)
      )
    end
  end
end
