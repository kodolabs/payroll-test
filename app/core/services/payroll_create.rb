class Services::PayrollCreate
  def process
    create_new_payroll
  end

  private
  def create_new_payroll
    Payroll.create(starts_at: Utils::Schedule.next_interval_start, ends_at: Utils::Schedule.next_interval_end)
  end
end
