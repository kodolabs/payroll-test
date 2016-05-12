require 'rails_helper'

describe PayDatesHelper, :type => :helper do

  describe '#pay_dates' do

    let!(:pay_date_1) { FactoryGirl.create :pay_date, pay_date: 5 }
    let!(:pay_date_2) { FactoryGirl.create :pay_date, pay_date: 1 }
    let!(:pay_date_3) { FactoryGirl.create :pay_date, pay_date: 31 }
    let!(:pay_date_4) { FactoryGirl.create :pay_date, pay_date: 2 }


    it 'return ordered list of PayDates' do
      dates = helper.pay_dates
      expect(dates[0].object).to eq pay_date_2
      expect(dates[1].object).to eq pay_date_4
      expect(dates[2].object).to eq pay_date_1
      expect(dates[3].object).to eq pay_date_3
    end
  end

  describe '#new_pay_date' do
    it 'work fine' do
      expect(helper.new_pay_date).to_not be_nil
      expect(helper.new_pay_date.new_record?).to be_truthy
    end
  end

end