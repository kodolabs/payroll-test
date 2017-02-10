require 'rails_helper'

RSpec.describe PayrollsCreator do
  let(:payout_date) { Date.today }

  subject { described_class.new(payout_date: payout_date) }

  before { allow_any_instance_of(PeriodBuilder).to receive(:payout_days).and_return([5, 10]) }

  describe '#process' do
    let(:starts_at) { double }
    let(:ends_at) { double }
    let(:range) { double(first: starts_at, end: ends_at) }

    before { allow_any_instance_of(PeriodBuilder).to receive(:range).and_return(range) }

    after { subject.process }

    it 'creates new payroll' do
      expect(Payroll).to receive(:create!).with(starts_at: starts_at, ends_at: ends_at)
    end
  end
end
