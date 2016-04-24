require 'rails_helper'
require 'byebug'
RSpec.describe Payroll, type: :model do
  context 'start_payroll' do
    it 'testing of start_payroll with period 1,31' do
      allow(Time).to receive_message_chain(:new, :utc, :beginning_of_year).and_return(Time.parse('2016-01-01 00:00:00 UTC'))
      allow(Payroll).to receive(:sort_dates).and_return([1, 31])

      expect(subject.class.send(:start_payroll)).to eq({ start_at: Time.parse('2016-01-01 00:00:00.000000000 UTC'),
                                                         ends_at:  Time.parse('2016-01-30 00:00:00.000000000 UTC') })
    end

    it 'testing of start_payroll with period 1,1' do
      allow(Time).to receive_message_chain(:new, :utc, :beginning_of_year).and_return(Time.parse('2016-01-01 00:00:00 UTC'))
      allow(Payroll).to receive(:sort_dates).and_return([1, 1])

      expect(subject.class.send(:start_payroll)).to eq({ start_at: Time.parse('2016-01-01 00:00:00.000000000 UTC'),
                                                         ends_at:  Time.parse('2016-01-31 00:00:00.000000000 UTC') })
    end

    it 'testing of start_payroll with period 30,31' do
      allow(Time).to receive_message_chain(:new, :utc, :beginning_of_year).and_return(Time.parse('2016-01-01 00:00:00 UTC'))
      allow(Payroll).to receive(:sort_dates).and_return([30, 31])

      expect(subject.class.send(:start_payroll)).to eq({ start_at: Time.parse('2016-01-30 00:00:00.000000000 UTC'),
                                                         ends_at:  Time.parse('2016-01-30 00:00:00.000000000 UTC') })
    end

    it 'testing of start_payroll with period 5,20' do
      allow(Time).to receive_message_chain(:new, :utc, :beginning_of_year).and_return(Time.parse('2016-01-01 00:00:00 UTC'))
      allow(Payroll).to receive(:sort_dates).and_return([5, 20])

      expect(subject.class.send(:start_payroll)).to eq({ start_at: Time.parse('2016-01-05 00:00:00.000000000 UTC'),
                                                         ends_at:  Time.parse('2016-01-19 00:00:00.000000000 UTC') })
    end
  end
end