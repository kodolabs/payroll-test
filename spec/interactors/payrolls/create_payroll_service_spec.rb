RSpec.describe Payrolls::CreatePayrollService do
  subject { described_class.call(starts_at: starts_at, ends_at: ends_at) }

  context 'when valid data passed' do
    let(:starts_at) { Date.today }
    let(:ends_at) { Date.today }

    it 'creates new record' do
      expect { subject }.to change { Payroll.count }.from(0).to(1)
    end
  end

  context 'when not valid data passed' do
    context 'when nil passed' do
      let(:starts_at) { nil }
      let(:ends_at) { nil }

      it 'raises ArgumentError exeption' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when not Date passed' do
      let(:starts_at) { 'kama' }
      let(:ends_at) { 'pulya' }

      it 'raises ArgumentError exeption' do
        expect { subject }.to raise_error(ArgumentError)
      end

      it 'show proper message' do
        expect { subject }.to raise_error(/is not a Date/)
      end
    end
  end
end
