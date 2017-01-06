class Services::PayrollAutoCreate < Services::PayrollCreate
  def process
    if DateTime.now >= Utils::Schedule.last_interval_end
      super
    end
  end
end