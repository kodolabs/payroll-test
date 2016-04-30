require 'rails_helper'

RSpec.describe Payroll, type: :model do
  describe '.create' do
    before do
      stub_const("Payroll::START_DATES", [5, 20])
    end

    context 'no payrolls exist' do
      it 'creates payroll at the beginning of year' do
        payroll = Payroll.create

        expect(payroll.starts_at).to eq DateTime.parse('5 Jan 2016')
        expect(payroll.ends_at).to eq DateTime.parse('19 Jan 2016')
      end
    end
  end
end
