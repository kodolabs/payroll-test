class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  validates_date :ends_at, after: :starts_at, allow_blank: false
  validates_date :starts_at, allow_blank: false
end
