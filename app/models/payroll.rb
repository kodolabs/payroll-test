class Payroll < ActiveRecord::Base
  STARTS = 5
  ENDS = 15

  scope :ordered, -> { order(starts_at: :asc) }
  validates :starts_at, :ends_at, presence: true

  before_validation :set_payrolls_attributes, on: :create

  private

  def set_payrolls_attributes
    raise 'wrong days limints' unless valid_days_limit?
    self.starts_at = starts.to_date
    self.ends_at = ends.to_date
  end

  def valid_days_limit?
    STARTS > 0 && STARTS <= 30 && ENDS > 1 && ENDS <= 31 && ENDS > STARTS
  end

  def starts
    last_payroll ? get_starts_at : Time.now.change({ day: STARTS })
  end

  def ends
    last_payroll ? get_ends_at : Time.now.change({ day: ENDS - 1 }).change({ day: ENDS - 1 })
  end

  def last_payroll
    Payroll.ordered.last
  end

  def get_starts_at
    last_payroll.ends_at.advance({ days: 1 })
  end

  def spesific_cases?
    last_payroll.ends_at.end_of_month.day <= ENDS
  end

  def get_ends_at
    if self.starts_at.day != STARTS
      self.starts_at.advance({ months: spesific_cases? ? 0 : 1 }).
        change({ day: STARTS - 1 })
    else
      self.starts_at.change({ day: ENDS - 1 })
    end
  end
end
