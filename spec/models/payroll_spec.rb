require 'rails_helper'

describe Payroll do

  context 'Validation' do
    let(:valid_payroll) { FactoryGirl.create :payroll }
    let(:not_valid_payroll) { FactoryGirl.build :payroll, starts_at: 1.day.from_now, ends_at: 1.day.ago }

    it 'valid' do
      expect(valid_payroll).to be_valid
    end

    it 'not valid' do
      expect(not_valid_payroll).to_not be_valid
    end
  end

  context 'Scopes' do
    describe '#ordered' do

      let!(:payroll_1) { FactoryGirl.create :payroll, starts_at: 5.day.ago }
      let!(:payroll_2) { FactoryGirl.create :payroll, starts_at: 1.day.ago }
      let!(:payroll_3) { FactoryGirl.create :payroll, starts_at: 20.day.ago }
      let!(:payroll_4) { FactoryGirl.create :payroll, starts_at: 2.day.ago }

      it 'order by start date' do
        dates = Payroll.ordered.all.to_a
        expect(dates[0]).to eq payroll_3
        expect(dates[1]).to eq payroll_1
        expect(dates[2]).to eq payroll_4
        expect(dates[3]).to eq payroll_2
      end

    end
  end
end
