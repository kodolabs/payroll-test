class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }
  include PayrollHelper
  DATE_ARRAY = [5,20]
end
