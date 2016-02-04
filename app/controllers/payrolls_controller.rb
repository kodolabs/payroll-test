class PayrollsController < ApplicationController

  before_action :new_payroll, only: [:index]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    if Payroll.no_payrolls?
      Payroll.create(starts_at: '5 January'.to_date, ends_at: '19 January'.to_date)
      redirect_to action: :index
    else
      Payroll.next_payroll(Payroll.last_payroll)
      redirect_to action: :index
    end
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
