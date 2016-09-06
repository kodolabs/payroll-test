require 'rails_helper'

RSpec.describe PayrollsController do
  describe 'POST create' do
    it 'generate payroll and render index' do
      current_payroll_count = Payroll.count
      post :create

      expect(Payroll.count).to eq (current_payroll_count + 1)
      expect(response).to redirect_to(payrolls_path)
    end
  end
end
