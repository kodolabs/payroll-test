require 'rails_helper'

RSpec.describe Payroll, type: :model do
  describe 'exists_active_period?' do
    it 'no periods' do
      expect(Payroll.exists_active_period?).to be false
    end

    it 'all periods in the past' do
      create(:payroll, :starts_in_the_past)
      expect(Payroll.exists_active_period?).to be false
    end

    it 'exists active period' do
      create(:payroll, :starts_today)
      expect(Payroll.exists_active_period?).to be true
    end

    it 'exists active period in future' do
      create(:payroll, :starts_in_the_future)
      expect(Payroll.exists_active_period?).to be true
    end
  end
end
