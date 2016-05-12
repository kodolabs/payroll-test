class PayDatesController < ApplicationController

  helper PayDatesHelper

  def index
  end

  def create
    date = PayDate.new pay_date_params
    if date.save
      redirect_to action: :index
    else
      flash[:notice] = date.errors.full_messages
      redirect_to action: :index
    end
  end

  def destroy
    PayDate.where(id: params[:id]).destroy_all
    redirect_to :back
  end

  private

  def pay_date_params
    params.require(:pay_date).permit(:pay_date)
  end

end