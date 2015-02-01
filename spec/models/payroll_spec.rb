require 'rails_helper'

RSpec.describe Payroll, type: :model do

  let(:time) { Time.now.change(day: 15).to_date }

  before do
    Timecop.freeze(time)
  end

  def set_limits(starts, ends)
    stub_const("Payroll::STARTS", starts)
    stub_const("Payroll::ENDS", ends)
  end

  describe 'when limits are not changed' do

    before do
      set_limits(5, 25)
      @payroll = Payroll.create
    end

    it 'create first payroll' do
      expect(@payroll.starts_at).to eq(time.change(day: 5))
      expect(@payroll.ends_at).to eq(time.change(day: 24 ))
    end

    it 'sets dates for next payroll' do
      payroll2 = Payroll.create
      expect(payroll2.starts_at).to eq(time.change(day: 25))
      expect(payroll2.ends_at).to eq(time.change(day: 4).advance(months: 1))
    end
  end

  describe 'when limits is not valid' do
    after :each do
      expect{ Payroll.create }.to raise_error('wrong days limints')
    end

    it 'raise exception ends < starts' do
      set_limits(25, 5)
    end

    it 'raise exception ends == starts' do
      set_limits(15, 15)
    end

    it 'raise exception ends > 31' do
      set_limits(25, 35)
    end
  end

  describe 'when limits are changed' do

    before do
      set_limits(5, 25)
      @payroll = Payroll.create
    end

    it 'decreases edns and sets dates for next payroll' do
      set_limits(5, 23)
      payroll2 = Payroll.create
      expect(payroll2.starts_at).to eq(time.change(day: 25))
      expect(payroll2.ends_at).to eq(time.change(day: 4).advance(months: 1))

      payroll3 = Payroll.create
      expect(payroll3.starts_at).to eq(time.change(day: 5).advance(months: 1))
      expect(payroll3.ends_at).to eq(time.change(day: 22).advance(months: 1))
    end

    it 'increases edns and sets dates for next payroll' do
      set_limits(5, 26)
      payroll2 = Payroll.create
      expect(payroll2.starts_at).to eq(time.change(day: 25))
      expect(payroll2.ends_at).to eq(time.change(day: 4).advance(months: 1))

      payroll3 = Payroll.create
      expect(payroll3.starts_at).to eq(time.change(day: 5).advance(months: 1))
      expect(payroll3.ends_at).to eq(time.change(day: 25).advance(months: 1))
    end
  end

  describe 'spesific cases' do
    before do
      time = Time.now.change({ year: 2015, month: 2, day: 1 })
      Timecop.freeze(time.to_date)
      set_limits(5, 29)
    end

    it 'common year 29 feb' do
      payroll = Payroll.create
      expect(payroll.starts_at).to eq(time.change(day: 5))
      expect(payroll.ends_at).to eq(time.change(day: 28))

      payroll2 = Payroll.create
      expect(payroll2.starts_at).to eq(time.change(day: 1).advance(months: 1))
      expect(payroll2.ends_at).to eq(time.change(day: 4).advance(months: 1))
    end

  end
end
