class Payroll < ActiveRecord::Base
  PAYOUT_DAYS = [5, 20].freeze

  scope :ordered, -> { order(starts_at: :asc) }
end
