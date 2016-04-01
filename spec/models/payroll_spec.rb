require 'rails_helper'

RSpec.describe Payroll, type: :model do

  let(:today) {Time.new(2017, 1, 1).to_date}
  before {Timecop.freeze today}

  def set_points(starts, ends)
    stub_const('Payroll::STARTS', starts)
    stub_const('Payroll::ENDS', ends)
  end

  describe 'Creates' do
    let(:payroll) {Payroll.create}

    it 'with id = 1' do
      expect(payroll.id).to eq(1)
    end
    
    it 'with starts_at that exactly kind of Date' do
      expect(payroll.starts_at.class).to match Date
    end

    it 'handles different years' do
      expect(payroll.starts_at..payroll.ends_at).to cover(today)
    end
  end

  describe 'It raise ArgumentError' do
    after :each do
      expect{ Payroll.create }.to raise_error(ArgumentError)
    end

    it 'when STARTS == ENDS' do
      set_points(5,5)
    end

    it 'when STARTS > ENDS' do
      set_points(25, 5)
    end

    point = 'point is out of range'
    it "when end #{point}" do
      set_points(5, 32)
    end

    it "when start #{point}" do
      set_points(0, 30)
    end
  end
end
