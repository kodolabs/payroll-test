require 'rails_helper'

RSpec.describe PayrollService, type: :service do
  describe '#generate' do
    before do
      Timecop.freeze(Date.today.beginning_of_month)
    end

    after do
      Timecop.return
    end

    context 'generate first payroll' do
      it 'generate payroll' do
        new_payroll = create_payroll

        expect change(Payroll, :count).by(1)
        expect(new_payroll.starts_at.day).to eq (starts_day(0))
        expect(new_payroll.ends_at.day).to eq (ends_day(0))
      end
    end

    context 'generate next payroll' do
      before do
        create_payroll
      end

      it 'generate second payroll' do
        last_payroll = fetch_last_payroll
        current_payroll = create_payroll

        expect change(Payroll, :count).from(1).to(2)
        expect(last_payroll.ends_at).to eq (current_payroll.starts_at - 1.day)
        expect(current_payroll.starts_at.day).to eq (starts_day(1))
        expect(current_payroll.ends_at.day).to eq (ends_day(1))
      end
    end

    context 'check create next payroll after changing payroll periods' do
      before do
        starts_at =  Date.today.prev_month
        ends_at = starts_at + rand(21..27).days
        Payroll.create(starts_at: starts_at, ends_at: ends_at)
      end

      it 'generate next payroll' do
        last_payroll = fetch_last_payroll
        current_payroll = create_payroll

        expect change(Payroll, :count).from(1).to(2)
        expect(current_payroll.starts_at).not_to eq (last_payroll.ends_at + 1.day)
      end
    end
  end

  private

  def create_payroll
    payroll = PayrollService.new.generate
    payroll.save

    payroll
  end

  def fetch_last_payroll
    Payroll.last
  end

  def default_periods
    @default_periods ||= StubPayrollService::DEFAULT_STARTS_DAYS
  end

  def starts_day(period_number)
    default_periods[period_number]
  end

  def ends_day(period_number)
    period_number >= default_periods.count - 1 ? default_periods.first - 1 : default_periods[period_number + 1] - 1
  end
end
