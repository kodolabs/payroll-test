require 'rails_helper'

RSpec.describe PayrollService, type: :service do
  describe '#generate' do
    context 'generate first payroll' do
      it 'generate payroll' do
        current_payroll_count = Payroll.count
        create_payroll

        expect(Payroll.count).to eq (current_payroll_count + 1)
      end
    end

    context 'generate next payroll' do
      before do
        create_payroll
      end

      it 'generate second payroll' do
        current_payroll_count = fetch_payroll_count
        last_payroll = fetch_last_payroll
        current_payroll = create_payroll

        expect(Payroll.count).to eq (current_payroll_count + 1)
        expect(last_payroll.ends_at).to eq (current_payroll.starts_at - 1.day)
      end
    end

    context 'check create next payroll after changing payroll periods' do
      before do
        starts_at =  Date.today.prev_month
        ends_at = starts_at + rand(21..27).days
        Payroll.create(starts_at: starts_at, ends_at: ends_at)
      end

      it 'generate next payroll' do
        current_payroll_count = fetch_payroll_count
        last_payroll = fetch_last_payroll
        current_payroll = create_payroll

        expect(Payroll.count).to eq (current_payroll_count + 1)
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

  def fetch_payroll_count
    Payroll.count
  end
end
