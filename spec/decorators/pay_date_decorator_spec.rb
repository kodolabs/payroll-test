require 'rails_helper'

describe PayDateDecorator do

  describe '#show_date' do

    let(:pay_date) { FactoryGirl.create :pay_date }
    let(:pay_date_decorator) { pay_date.decorate }

    it 'for first day of the month' do
      pay_date.update(pay_date: 1)
      expect(pay_date_decorator.show_date).to eq 'First day of the month'
    end

    it 'for last day of the month' do
      pay_date.update(pay_date: 31)
      expect(pay_date_decorator.show_date).to eq 'Last day of the month'
    end


    it 'any day within month' do
      pay_date.update(pay_date: 15)
      expect(pay_date_decorator.show_date).to eq 'Every 15 day'
    end


  end

end