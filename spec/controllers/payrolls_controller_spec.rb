require 'rails_helper'

RSpec.describe PayrollsController, type: :controller do
  describe 'POST #create' do
    subject { post :create }

    before do
      Payroll.create starts_at: DateTime.new(2016, 8, 18), ends_at: DateTime.new(2016, 9, 8)
      Payroll.create starts_at: DateTime.new(2016, 9, 9), ends_at: DateTime.new(2016, 9, 18)
    end

    it 'should create new when needed' do
      Timecop.freeze(DateTime.new(2016, 10, 10)) do
        expect{subject}.to change{Payroll.count}.from(2).to(3)
        expect(flash[:success]).to be_present
        is_expected.to redirect_to(:action => :index)
      end
    end

    it 'should not create when not needed' do
      Timecop.freeze(DateTime.new(2016, 9, 10)) do
        expect{subject}.to_not change{Payroll.count}
        expect(flash[:error]).to be_present
        is_expected.to redirect_to(:action => :index)
      end
    end
  end
end