class Services::PayrollAutoCreate < Services::PayrollCreate
  def process
    if DateTime.now >= Payroll.last_ends_at
      super
    end
  end
end