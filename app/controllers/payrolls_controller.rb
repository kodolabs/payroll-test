class PayrollsController < ApplicationController

  before_action :new_payroll, only: [:index]
  before_action :set_interval, only: [:create]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    Payroll.create(starts_at: @starts_at, ends_at: @ends_at)
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

  def set_interval
    @starts_at, @ends_at = Payroll.set_interval
  end


end
