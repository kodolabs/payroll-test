class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  FIRST_HALF_STARTS_AT = 5
  SECOND_HALF_STARTS_AT = 20

  validates_presence_of :starts_at
  validates_presence_of :ends_at
end
