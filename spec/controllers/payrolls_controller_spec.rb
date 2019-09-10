require 'rails_helper'

RSpec.describe PayrollsController, type: :controller do
  describe 'POST#create' do
    subject(:request) { post(:create) }

    it 'redirects to /payrolls' do
      expect(request).to redirect_to(:payrolls)
    end

    it 'creates payroll' do
      expect { request }.to change(Payroll, :count).by(1)
    end
  end
end
