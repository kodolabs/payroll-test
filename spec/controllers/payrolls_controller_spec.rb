require 'rails_helper'

RSpec.describe PayrollsController, type: :controller do
  before { allow_any_instance_of(PeriodBuilder).to receive(:payout_days).and_return([5, 10]) }

  describe 'POST #create' do
    it 'calls PayrollsCreator' do
      expect_any_instance_of(PayrollsCreator).to receive(:process)
      post :create
    end
  end
end
