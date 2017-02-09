class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  validates :starts_at, :ends_at, uniqueness: true
  validates :starts_at, :ends_at, presence: true
  # Also we have to add indexes for uniqueness and presence in DB
end
