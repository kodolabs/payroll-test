class Services::PayrollCreate
  def process
    create_new_payroll
  end

  def create_new_payroll
    starts_at = Payroll.last_ends_at + 1.day
    ends_at = Utils::Schedule.next_scheduled_date_exclusive(starts_at + 1.day)
    Payroll.create(starts_at: starts_at, ends_at: ends_at)
  end
end