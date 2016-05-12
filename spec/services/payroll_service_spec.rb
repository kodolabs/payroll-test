require 'rails_helper'

describe PayrollService do

  describe '#next_date' do

    context 'with PayDates' do
      before :each do
        PayDate.create pay_date: 5
        PayDate.create pay_date: 18
      end

      it 'without payroll' do
        expect(PayrollService.new.next_date).to eq Date.new(Date.today.year, Date.today.month, 5)
      end

      it 'for Payroll before first `pay_date`' do
        payroll = FactoryGirl.create :payroll, starts_at: Date.new(2014, 9, 25), ends_at: Date.new(2014, 10, 3)
        expect(PayrollService.new(payroll).next_date.to_date).to eq Date.new(2014, 10, 5)
      end

      it 'for Payroll between two `pay_dates`' do
        payroll = FactoryGirl.create :payroll, starts_at: Date.new(2014, 9, 25), ends_at: Date.new(2014, 10, 9)
        expect(PayrollService.new(payroll).next_date.to_date).to eq Date.new(2014, 10, 18)
      end

      it 'for Payroll after second `pay_dats`' do
        payroll = FactoryGirl.create :payroll, starts_at: Date.new(2014, 9, 25), ends_at: Date.new(2014, 10, 19)
        expect(PayrollService.new(payroll).next_date.to_date).to eq Date.new(2014, 11, 5)
      end

      it 'for Payroll after second `pay_dats` (end of month)' do
        payroll = FactoryGirl.create :payroll, starts_at: Date.new(2014, 9, 25), ends_at: Date.new(2014, 10, 19).end_of_month
        expect(PayrollService.new(payroll).next_date.to_date).to eq Date.new(2014, 11, 5)
      end
    end

    context 'withour PayDates' do
      it 'return nil' do
        expect(PayrollService.new.next_date).to be_nil
      end
    end

  end

  describe '#create' do

    context 'without PayDates' do
      it 'return false' do

        expect(PayrollService.new.create).to be_falsy

      end
    end

    context 'with PayDates' do
      before :each do
        PayDate.create pay_date: 5
        PayDate.create pay_date: 18
      end

      it 'without previous payroll' do
        created = PayrollService.new.create
        expect(created).to_not be_nil
        expect(created.starts_at.to_date).to eq Date.today.at_beginning_of_month
        expect(created.ends_at.to_date).to eq Date.new(Date.today.year, Date.today.month, 5)
      end

      it 'for Payroll before first `pay_date`' do
        payroll = FactoryGirl.create :payroll, starts_at: Date.new(2014, 9, 25), ends_at: Date.new(2014, 10, 3)

        created = PayrollService.new(payroll).create
        expect(created).to_not be_nil
        expect(created.starts_at).to eq payroll.ends_at
        expect(created.ends_at.to_date).to eq Date.new(2014, 10, 5)
      end

      it 'for Payroll between two `pay_dates`' do
        payroll = FactoryGirl.create :payroll, starts_at: Date.new(2014, 9, 25), ends_at: Date.new(2014, 10, 9)

        created = PayrollService.new(payroll).create
        expect(created).to_not be_nil
        expect(created.starts_at).to eq payroll.ends_at
        expect(created.ends_at.to_date).to eq Date.new(2014, 10, 18)
      end

      it 'for Payroll after second `pay_dats`' do
        payroll = FactoryGirl.create :payroll, starts_at: Date.new(2014, 9, 25), ends_at: Date.new(2014, 10, 19)

        created = PayrollService.new(payroll).create
        expect(created).to_not be_nil
        expect(created.starts_at).to eq payroll.ends_at
        expect(created.ends_at.to_date).to eq Date.new(2014, 11, 5)
      end

    end

  end

end