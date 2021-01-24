# frozen_string_literal: true

class PayrollsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :new_payroll, only: [:index]

  def index
    @payrolls = Payroll.ordered.all
  end

  def create
    CreatePayrollQuery.new(start_date: params[:start_date], end_date: params[:end_date]).invoke
    redirect_to action: :index
  end

  def destroy
    @payroll = Payroll.find params[:id]
    redirect_to action: :index if @payroll.destroy
  end

  private

  def new_payroll
    @new_payroll = Payroll.new
  end
end