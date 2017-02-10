require 'rails_helper'

RSpec.describe PeriodBuilder do
  let(:date) { Date.today }
  let(:payout_days) { [5, 10] }
  let(:instance) { described_class.new(date) }

  before { allow_any_instance_of(PeriodBuilder).to receive(:payout_days).and_return(payout_days) }

  describe '#range' do
    subject { instance.range }

    it { is_expected.to be_a Range }

    context 'between 0 and 5' do
      let(:date) { Date.parse('3 Jan 2017') }

      it 'should include only one payout day' do
        intersection = subject.map(&:day) & payout_days
        expect(payout_days).to include(subject.end.day)
        expect(intersection.length).to eq(1)
      end
    end

    context 'between 5 and 10' do
      let(:date) { Date.parse('7 Jan 2017') }

      it 'should include only one payout day' do
        intersection = subject.map(&:day) & payout_days
        expect(payout_days).to include(subject.end.day)
        expect(intersection.length).to eq(1)
      end
    end

    context 'between 10 and 28' do
      let(:date) { Date.parse('27 Jan 2017') }

      it 'should include only one payout day' do
        intersection = subject.map(&:day) & payout_days
        expect(payout_days).to include(subject.end.day)
        expect(intersection.length).to eq(1)
      end
    end
  end
end
