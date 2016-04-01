class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }
  STARTS = 5
  ENDS = 20

  validates_presence_of :starts_at, :ends_at
  before_validation :set_attributes, on: :create

  def set_attributes
    raise ArgumentError unless
        STARTS.between?(1, 31) && ENDS.between?(1, 31) && STARTS != ENDS && STARTS < ENDS

    self.starts_at =
      Payroll.ordered.last ? Payroll.ordered.last.ends_at + 1.day : Time.new.change(day: STARTS).to_date

    self.ends_at =
      if starts_at.day != STARTS
        (starts_at + 1.month).change(day: STARTS - 1)
      else
        starts_at.change(day: ENDS - 1)
      end
  end
end
