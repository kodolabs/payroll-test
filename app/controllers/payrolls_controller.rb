class PayrollsController < ApplicationController

  before_action :new_payroll, :autocreate, only: [:index]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    redirect_to action: :index if Payroll.create
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

   def autocreate
    payrolls = Payroll.ordered.all
    if payrolls.last
      Payroll.create if Time.now.day.between?(
        payrolls.first.starts_at.day, payrolls.last.ends_at.day)
    else
      Payroll.create
    end 
  end
end
