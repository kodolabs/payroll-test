require 'rails_helper'

describe PayDate do

  context 'Factory' do
    let(:date) { FactoryGirl.create :pay_date }

    it 'valid' do
      expect(date).to be_valid
    end
  end

  context 'Validations' do
    it { expect(subject).to validate_presence_of(:pay_date) }
    it { expect(subject).to validate_numericality_of(:pay_date).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(31) }
    it { expect(subject).to validate_uniqueness_of(:pay_date) }
  end

  describe 'Scopes' do
    describe '#ordered' do

      let!(:pay_date_1) { FactoryGirl.create :pay_date, pay_date: 5 }
      let!(:pay_date_2) { FactoryGirl.create :pay_date, pay_date: 1 }
      let!(:pay_date_3) { FactoryGirl.create :pay_date, pay_date: 31 }
      let!(:pay_date_4) { FactoryGirl.create :pay_date, pay_date: 2 }

      it 'order by pay date' do
        dates = PayDate.ordered.all.to_a
        expect(dates[0]).to eq pay_date_2
        expect(dates[1]).to eq pay_date_4
        expect(dates[2]).to eq pay_date_1
        expect(dates[3]).to eq pay_date_3
      end

    end
  end

  describe 'Callbacks' do
    it { expect(subject).to callback(:check_pay_date).after(:validation) }
  end
end
