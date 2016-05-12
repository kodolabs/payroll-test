module PayDatesHelper

  def pay_dates
    @pay_dates ||= PayDateDecorator.decorate_collection PayDate.ordered.all
  end

  def new_pay_date
    @new_pay_date ||= PayDate.new
  end

end