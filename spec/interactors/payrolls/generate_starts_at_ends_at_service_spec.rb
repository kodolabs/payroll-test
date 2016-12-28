RSpec.describe Payrolls::GenerateStartsAtEndsAtService do
  let(:year) { 2011 }
  let(:month) { 8 }
  let(:day) { 16 }

  subject { described_class.call() }

  around do |example|
    Timecop.freeze(Date.new(year, month, day), &example)
  end

  context 'when there is no payrolls' do
    let(:starts_at) { Date.new(year, month, Payroll::SECOND_HALF_STARTS_AT) }
    let(:ends_at) { Date.new(year, month + 1, Payroll::FIRST_HALF_STARTS_AT - 1) }

    it 'generate starts_at for next half regarding today' do
      expect(subject.starts_at).to eq(starts_at)
    end

    it 'generate ends_at for next half regarding today' do
      expect(subject.ends_at).to eq(ends_at)
    end
  end

  context 'when there is some payrolls' do
    let(:year) { 2010 }
    let(:month) { 9 }
    let(:starts_at) { Date.new(year, month + 1, Payroll::FIRST_HALF_STARTS_AT) }
    let(:ends_at) { Date.new(year, month + 1, Payroll::SECOND_HALF_STARTS_AT - 1) }

    before do
      FactoryGirl.create(
        :payroll,
        starts_at: Date.new(year, month, Payroll::SECOND_HALF_STARTS_AT),
        ends_at: Date.new(year, month + 1, Payroll::FIRST_HALF_STARTS_AT - 1)
      )
    end

    it 'generate starts_at for next half regarding last payroll' do
      expect(subject.starts_at).to eq(starts_at)
    end

    it 'generate ends_at for next half regarding last payroll' do
      expect(subject.ends_at).to eq(ends_at)
    end
  end
end
