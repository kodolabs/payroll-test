class Payroll < ActiveRecord::Base
  PAYMENT_DAYS = [5, 20]
  scope :ordered, -> { order(starts_at: :asc) }
end
