require 'rails_helper'

RSpec.describe PayoutSchedule, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:day_of_month) }
    it { is_expected.to validate_uniqueness_of(:day_of_month) }
    it do
      is_expected.to validate_numericality_of(:day_of_month).
        is_greater_than_or_equal_to(1).
        is_less_than_or_equal_to(28)
    end
  end
end
