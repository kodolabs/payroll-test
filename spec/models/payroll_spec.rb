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
      Timecop.freeze(DateTime.new(2016, 9, 18)) do
        # last payroll till today
        expect(Payroll.time_for_a_new_one).to be false
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

  context 'dates calculation' do
    before do
      Rails.configuration.payroll_days = [3, 18, 30]
    end

    subject { Payroll }

    it 'calculates next date' do
      expect(subject.send(:next_date, DateTime.new(2016, 2, 20))).to eq(DateTime.new(2016, 2, 29))
      expect(subject.send(:next_date, DateTime.new(2016, 8, 30))).to eq(DateTime.new(2016, 9, 3))
      expect(subject.send(:next_date, DateTime.new(2016, 12, 30))).to eq(DateTime.new(2017, 1, 3))
    end

    it 'calculates prev date' do
      expect(subject.send(:prev_date, DateTime.new(2016, 2, 3))).to eq(DateTime.new(2016, 1, 30))
      expect(subject.send(:prev_date, DateTime.new(2016, 3, 3))).to eq(DateTime.new(2016, 2, 29))
    end
  end
end
