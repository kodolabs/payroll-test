require 'rails_helper'
RSpec.describe PayrollsController, type: :controller do
  describe 'GET #index creates payroll' do
    it 'automaticaly if we havn\'t payroll for today' do
      get 'index'
      payroll = Payroll.ordered.last
      expect(payroll.starts_at..payroll.ends_at).to cover(Date.today)
    end
  end
end
