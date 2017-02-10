require 'rails_helper'

RSpec.describe PayrollDay, type: :model do

  it 'must contain at last one record' do
    expect(PayrollDay.count > 0).to eq(true)
  end

  it 'must contain only days >= 1 and <= 28' do
    expect(PayrollDay.pluck(:day).all? {|d| d >= 1 && d <= 28 }).to eq(true)
  end

end
