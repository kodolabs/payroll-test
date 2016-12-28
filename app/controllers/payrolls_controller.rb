class PayrollsController < ApplicationController
  before_action :new_payroll, only: [:index]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    Payrolls::GeneratePayrollOrganizer.call
    redirect_to action: :index
  end

  def destroy
    @payroll = Payroll.find params[:id]
    redirect_to :back if @payroll.destroy
  end

  private

  def new_payroll
    @new_payroll = Payroll.new
  end
end
