require 'rails_helper'

RSpec.describe Payroll, type: :model do
  before do
    Rails.configuration.payroll_days = [3, 18]
  end

  subject { Payroll.new_with_dates }

  context 'with history' do
    before do
      Payroll.create starts_at: DateTime.new(2016, 8, 18), ends_at: DateTime.new(2016, 9, 8)
      Payroll.create starts_at: DateTime.new(2016, 9, 9), ends_at: DateTime.new(2016, 9, 18)
    end

    it 'detects next one needed' do
      Timecop.freeze(DateTime.new(2016, 10, 11)) do
        expect(Payroll.time_for_a_new_one).to be true
      end
    end

    it 'detects next one not needed' do
      Timecop.freeze(DateTime.new(2016, 9, 11)) do
        expect(Payroll.time_for_a_new_one).to be false
      end
    end

    it 'sets correct dates' do
      expect(subject.starts_at).to eq(DateTime.new(2016, 9, 19))
      expect(subject.ends_at).to eq(DateTime.new(2016, 10, 3))
    end
  end

  context 'without history' do
    it 'detects next one needed' do
      expect(Payroll.time_for_a_new_one).to be true
    end

    it 'sets correct dates' do
      Timecop.freeze(DateTime.new(2016, 9, 11)) do
        expect(subject.starts_at).to eq(DateTime.new(2016, 9, 3))
        expect(subject.ends_at).to eq(DateTime.new(2016, 9, 18))
      end
    end
  end
end
