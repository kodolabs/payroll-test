require 'rails_helper'

RSpec.describe Payroll, type: :model do

  describe '.calc_ends_at' do
    it 'return 2017-01-19 for 2017-01-05' do
      expect(Payroll.send(:calc_ends_at, Date.parse('2017-01-05'))).to eq(Date.parse('2017-01-19'))
    end
    it 'return 2017-01-04 for 2016-12-25' do
      expect(Payroll.send(:calc_ends_at, Date.parse('2016-12-25'))).to eq(Date.parse('2017-01-04'))
    end
  end

end
