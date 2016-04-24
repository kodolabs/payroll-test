require 'rails_helper'

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
                                                         ends_at:  Time.parse('2016-01-31 23:59:59.999999999 UTC') })
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

  context 'standard_payroll' do
    it 'testing of last date 04-19 with period 5,20'do
      allow(Payroll).to receive(:sort_dates).and_return([5, 20])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-04-19 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-04-20 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-05-04 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 04-04 with period 5,20'do
      allow(Payroll).to receive(:sort_dates).and_return([5, 20])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-04-04 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-04-05 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-04-19 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 02-04 with period 5,31' do
      allow(Payroll).to receive(:sort_dates).and_return([5, 31])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-02-04 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-02-05 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-02-29 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 01-31 with period 1,31' do
      allow(Payroll).to receive(:sort_dates).and_return([1, 31])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-01-31 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-02-01 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-02-29 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 03-30 with period 1,31' do
      allow(Payroll).to receive(:sort_dates).and_return([1, 31])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-03-30 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-03-31 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-03-31 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 03-31 with period 1,31' do
      allow(Payroll).to receive(:sort_dates).and_return([1, 31])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-03-31 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-04-01 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-04-30 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 01-30 with period 31,31' do
      allow(Payroll).to receive(:sort_dates).and_return([31, 31])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-01-30 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-01-31 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-02-29 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 02-29 with period 31,31' do
      allow(Payroll).to receive(:sort_dates).and_return([31, 31])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-02-29 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-03-01 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-03-30 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 01-31 with period 1,1' do
      allow(Payroll).to receive(:sort_dates).and_return([1, 1])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-01-31 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-02-01 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-02-29 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 02-29 with period 1,1' do
      allow(Payroll).to receive(:sort_dates).and_return([1, 1])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-02-29 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-03-01 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-03-31 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 01-29 with period 30,31' do
      allow(Payroll).to receive(:sort_dates).and_return([30, 31])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-01-29 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-01-30 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-01-30 23:59:59.999999999 UTC') })
    end

    it 'testing of last date 01-30 with period 30,31' do
      allow(Payroll).to receive(:sort_dates).and_return([30, 31])
      allow(Payroll).to receive_message_chain(:ordered, :last, :ends_at, :to_s).and_return('2016-01-30 23:59:59.999999999 UTC')

      expect(subject.class.send(:standard_payroll)).to eq({ start_at: Time.parse('2016-01-31 23:59:59.999999999 UTC'),
                                                            ends_at:  Time.parse('2016-02-29 23:59:59.999999999 UTC') })
    end
  end
end