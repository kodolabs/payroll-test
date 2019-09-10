class PayrollsController < ApplicationController

  before_action :new_payroll, only: [:index]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    CreatePayrollService.call(payrolls_collection: Payroll.ordered)
    redirect_to action: :index
  end

  def destroy
    @payroll = Payroll.find params[:id]
    if @payroll.destroy
      redirect_to :back
    end
  end

  private

  def new_payroll
    @new_payroll = Payroll.new
  end
end
