class PayrollService

  def initialize(last_payroll=nil)
    @last_payroll_day = last_payroll&.ends_at || Date.today.at_beginning_of_month
    @search_payroll_day = @last_payroll_day.end_of_month == @last_payroll_day ? 31 : @last_payroll_day.day
    self
  end

  def create
    return nil unless next_date
    Payroll.create(starts_at: @last_payroll_day, ends_at: next_date.to_date)
  end

  def next_date
    @next_date ||= init_next_date
  end

  private

  def init_next_date
    if PayDate.where('pay_date > ?', @search_payroll_day).exists?
      day = PayDate.ordered.where('pay_date > ?', @search_payroll_day).limit(1).pluck(:pay_date).first
      @last_payroll_day.clone.change(day: day)
    elsif PayDate.where('pay_date <= ?', @search_payroll_day).exists?
      day = PayDate.ordered.where('pay_date <= ?', @search_payroll_day).limit(1).pluck(:pay_date).first
      @last_payroll_day.clone.change(month: (@last_payroll_day.month+1), day: day)
    else
      nil
    end
  end

end