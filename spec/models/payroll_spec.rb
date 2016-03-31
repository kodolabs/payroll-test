require 'rails_helper'

RSpec.describe Payroll, type: :model do

	let(:time) {Time.new(2010, 3, 6).to_date}
	before {Timecop.freeze time}

  def set_points(starts, ends)
  	stub_const('Payroll::STARTS', starts)
  	stub_const('Payroll::ENDS', ends)
  end

  describe 'Creates Payroll' do

  	let(:payroll) {Payroll.create}

	  it 'with id = 1' do
	  	expect(payroll.id).to eq(1)
	  end
	  
		it 'with starts_at that exactly kind of ActiveSupport::TimeWithZone' do
			expect(payroll.starts_at.class).to match ActiveSupport::TimeWithZone
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

  	msg = 'point is out of range'
  	it "when end #{msg}" do
  		set_points(5, 32)
  	end

  	it "when start #{msg}" do
  		set_points(0, 30)
  	end
  end
end
