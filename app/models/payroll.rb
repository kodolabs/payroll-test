class Payroll < ActiveRecord::Base
  include PayrollCreateHelper

  scope :ordered, -> { order(starts_at: :asc) }

  START_DATES = [5, 20]

  def self.create(attributes = nil, &block)
    if count == 0
      super(first_payroll_parameters, &block)
    else
      super(payroll_parameters, &block)
    end
  end
end
