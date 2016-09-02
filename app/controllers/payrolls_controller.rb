class PayrollsController < ApplicationController

  before_action :new_payroll, only: [:index]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    payroll = PayrollService.new.generate

    if payroll.save
      flash[:notice] = 'Payroll was successfully created'
    else
      flash[:error] = payroll.errors.full_message
    end

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
