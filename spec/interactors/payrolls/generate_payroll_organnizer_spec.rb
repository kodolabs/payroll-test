RSpec.describe Payrolls::GeneratePayrollOrganizer do
  around do |example|
    Timecop.freeze(Date.new(2010, 10, Payroll::SECOND_HALF_STARTS_AT - 1), &example)
  end

  # TODO: MB we need better test for this
  # TODO: Need to test months and years too
  context 'when called multiple times (10)' do
    before do
      10.times { described_class.call }
    end

    it 'creates proper payrolls with blinkking days' do
      payrolls = Payroll.ordered
      days = payrolls.map { |m| m.starts_at.day }
                     .each_slice(2).with_object([]) { |(a, b), o| o << [a, b] }
                     .uniq
                     .flatten
      expect(days).to eq([Payroll::SECOND_HALF_STARTS_AT, Payroll::FIRST_HALF_STARTS_AT])
    end
  end
end
