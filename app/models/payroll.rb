class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  PAY_DAYS = [5, 20].freeze

  validates :starts_at, presence: true
  validates :ends_at,   presence: true
end
