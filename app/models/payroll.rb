class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  class << self

    INTERVAL =   { starts_at: 5, ends_at: 20 }

    PERIOD = { starts_at: Time.new.utc.beginning_of_year, ends_at: Time.new.utc.end_of_year}

    def set_interval
      starts_at = Payroll.count == 0 ? set_first_starts_at : set_any_starts_at
      ends_at = starts_at.change(day: INTERVAL[:ends_at] - 1) < starts_at.end_of_month && starts_at < starts_at.change(day: INTERVAL[:ends_at] - 1) ? starts_at.change(day: INTERVAL[:ends_at] - 1) : (starts_at + 1.month).change(day: INTERVAL[:starts_at] - 1)

      [starts_at, ends_at]    
    end

    def set_first_starts_at
      date = PERIOD[:starts_at].day > INTERVAL[:starts_at] ? PERIOD[:starts_at] + 1.month : PERIOD[:starts_at]
      date.change(day: INTERVAL[:starts_at])
    end

    def set_any_starts_at
      Payroll.ordered.last.ends_at + 1.day
    end

  end
end
