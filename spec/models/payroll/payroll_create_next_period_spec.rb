require 'rails_helper'

RSpec.describe Payroll, type: :model do
  describe 'create_next_period' do
    describe '1 payment day' do
      describe 'with periods' do
        it do
          stub_const("Payroll::PAYMENT_DAYS", [1])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-01-01'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-02'.to_date, ends_at: '2016-01-31'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [1])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-01-31'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-02-01'.to_date, ends_at: '2016-02-29'.to_date)
          Payroll.create_next_period
        end
      end

      describe 'without periods' do
        it do
          stub_const("Payroll::PAYMENT_DAYS", [1])
          expect(Date).to receive(:today).and_return('2016-01-01'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-01'.to_date, ends_at: '2016-01-31'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [1])
          expect(Date).to receive(:today).and_return('2016-01-02'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-02-01'.to_date, ends_at: '2016-02-29'.to_date)
          Payroll.create_next_period
        end
      end
    end

    describe '2 payment days' do
      describe 'with periods' do
        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-01-04'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-05'.to_date, ends_at: '2016-01-19'.to_date)
          Payroll.create_next_period
        end
        
        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-01-19'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-20'.to_date, ends_at: '2016-02-04'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-02-04'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-02-05'.to_date, ends_at: '2016-02-19'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-02-19'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-02-20'.to_date, ends_at: '2016-03-04'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-03-04'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-03-05'.to_date, ends_at: '2016-03-19'.to_date)
          Payroll.create_next_period
        end
      end

      describe 'without periods' do
        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Date).to receive(:today).and_return('2016-01-01'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-05'.to_date, ends_at: '2016-01-19'.to_date)
          Payroll.create_next_period
        end
        
        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Date).to receive(:today).and_return('2016-01-05'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-05'.to_date, ends_at: '2016-01-19'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Date).to receive(:today).and_return('2016-01-10'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-20'.to_date, ends_at: '2016-02-04'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Date).to receive(:today).and_return('2016-01-20'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-20'.to_date, ends_at: '2016-02-04'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [5, 20])
          expect(Date).to receive(:today).and_return('2016-01-22'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-02-05'.to_date, ends_at: '2016-02-19'.to_date)
          Payroll.create_next_period
        end
      end
    end

    describe '3 payment days' do
      describe 'with periods' do
        it do
          stub_const("Payroll::PAYMENT_DAYS", [4, 5, 15])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-01-03'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-04'.to_date, ends_at: '2016-01-04'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [4, 5, 15])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-01-04'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-05'.to_date, ends_at: '2016-01-14'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [4, 5, 15])
          expect(Payroll).to receive(:maximum).with(:ends_at).and_return('2016-01-14'.to_date)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-15'.to_date, ends_at: '2016-02-03'.to_date)
          Payroll.create_next_period
        end
      end

      describe 'without periods' do
        it do
          stub_const("Payroll::PAYMENT_DAYS", [4, 5, 15])
          expect(Date).to receive(:today).and_return('2016-01-01'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-04'.to_date, ends_at: '2016-01-04'.to_date)
          Payroll.create_next_period
        end

        it do
          stub_const("Payroll::PAYMENT_DAYS", [4, 5, 15])
          expect(Date).to receive(:today).and_return('2016-01-06'.to_date).at_least(:once)
          expect(Payroll).to receive(:create).with(starts_at: '2016-01-15'.to_date, ends_at: '2016-02-03'.to_date)
          Payroll.create_next_period
        end
      end
    end
  end
end
