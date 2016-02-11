class PayrollsController < ApplicationController

  before_action :new_payroll, only: [:index]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    if Payroll.time_for_a_new_one
      p = Payroll.new_with_dates
      if p.save
        flash[:success] = 'New Payroll created'
      else
        flash[:error] = 'Could not save a new Payroll'
      end
    else
      flash[:error] = 'Not a time for a new Payroll'
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
