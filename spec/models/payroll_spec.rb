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

    context 'there are some payrolls' do
      it 'creates payroll next to the previous' do
        Payroll.create
        payroll = Payroll.create

        expect(payroll.starts_at).to eq DateTime.parse("20 Jan 2016")
        expect(payroll.ends_at).to eq DateTime.parse("4 Feb 2016")
      end

      it 'creates payroll correctly at right boundary' do
        stub_const("Payroll::START_DATES", [5, 31])
        Payroll.create

        payroll = Payroll.create

        expect(payroll.starts_at).to eq DateTime.parse("31 Jan 2016")
        expect(payroll.ends_at).to eq DateTime.parse("4 Feb 2016")
      end

      it 'creates payroll correctly at left boundary' do
        stub_const("Payroll::START_DATES", [1, 20])
        3.times { Payroll.create }

        payroll = Payroll.create

        expect(payroll.starts_at).to eq DateTime.parse("20 Feb 2016")
        expect(payroll.ends_at).to eq DateTime.parse("29 Feb 2016")
      end
    end
  end
end
