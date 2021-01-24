# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreatePayrollQuery do
  describe '#invoke' do
    it 'should return new pay_roll with first half of month' do
      Payroll.destroy_all
      Payroll.create(starts_at: DateTime.new(2020, 12, 5), ends_at: DateTime.new(2020, 12, 19))

      expect(Payroll.count).to eq(1)

      described_class.new({}).invoke

      last_pay_roll = Payroll.last

      expect(Payroll.count).to eq(2)
      expect(last_pay_roll.starts_at.day).to eq(20)
      expect(last_pay_roll.ends_at.day).to eq(4)
    end

    it 'should return new pay_roll with second half of month' do
      Payroll.destroy_all
      Payroll.create(starts_at: DateTime.new(2020, 11, 20), ends_at: DateTime.new(2020, 12, 4))

      expect(Payroll.count).to eq(1)

      described_class.new({}).invoke

      last_pay_roll = Payroll.last

      expect(Payroll.count).to eq(2)
      expect(last_pay_roll.starts_at.day).to eq(5)
      expect(last_pay_roll.ends_at.day).to eq(19)
    end

    it 'should return new pay_roll with specific date' do
      Payroll.destroy_all
      Payroll.create(starts_at: DateTime.new(2020, 11, 20), ends_at: DateTime.new(2020, 12, 4))

      expect(Payroll.count).to eq(1)

      described_class.new({ start_date: DateTime.new(2021, 1, 6), end_date: DateTime.new(2021, 1, 20) }).invoke

      last_pay_roll = Payroll.last
      expect(Payroll.count).to eq(2)
      expect(last_pay_roll.starts_at.day).to eq(6)
      expect(last_pay_roll.ends_at.day).to eq(20)
    end

    it 'should create first pay roll' do
      Payroll.destroy_all

      expect(Payroll.count).to eq(0)

      described_class.new({}).invoke

      last_pay_roll = Payroll.last
      expect(Payroll.count).to eq(1)
      expect(last_pay_roll.starts_at.day).to eq(5)
      expect(last_pay_roll.ends_at.day).to eq(19)
    end

    it 'should create correct pay_roll with change month' do
      Payroll.destroy_all
      Payroll.create(starts_at: DateTime.new(2021, 1, 20), ends_at: DateTime.new(2021, 2, 4))

      expect(Payroll.count).to eq(1)

      described_class.new({}).invoke

      last_pay_roll = Payroll.last
      expect(Payroll.count).to eq(2)
      expect(last_pay_roll.starts_at.day).to eq(5)
      expect(last_pay_roll.ends_at.day).to eq(19)
    end

    it 'should create correct pay_roll with change month' do
      Payroll.destroy_all
      Payroll.create(starts_at: DateTime.new(2021, 2, 20), ends_at: DateTime.new(2021, 3, 4))

      expect(Payroll.count).to eq(1)

      described_class.new({}).invoke

      last_pay_roll = Payroll.last
      expect(Payroll.count).to eq(2)
      expect(last_pay_roll.starts_at.day).to eq(5)
      expect(last_pay_roll.ends_at.day).to eq(19)
    end
  end
end
