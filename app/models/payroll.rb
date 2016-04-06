class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }
  STARTS = 5
  ENDS = 20

  validates_presence_of :starts_at, :ends_at
  before_validation :set_attributes, on: :create

  def set_attributes
    raise ArgumentError unless
      STARTS.between?(0, 31) && ENDS.between?(0, 31) &&
      STARTS != ENDS && STARTS < ENDS

    self.starts_at = starts
    self.ends_at = ends
  end

  def starts
    if last_p
      last_p.ends_at + 1.day
    elsif today.day.between?(STARTS, (ENDS - 1))
      today.change(day: STARTS).to_date
    elsif today.month == 1
      today.change(day: ENDS, month: 12, year: (today.year - 1))
    else
      today.change(day: ENDS, month: (today.month - 1))
    end
  end

  def ends
    if starts_at.day != STARTS
      (starts_at + 1.month).change(day: STARTS - 1)
    else
      starts_at.change(day: ENDS - 1)
    end
  end

  def autocreate
    if Payroll.any?
      Payroll.create if Date.today > payroll.ends_at
    else
      Payroll.create
    end
  end

  private
    def last_p
      Payroll.ordered.last
    end

    def today
      Date.today
    end
end
