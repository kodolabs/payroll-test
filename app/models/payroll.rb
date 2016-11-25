class Payroll < ActiveRecord::Base
  START_DATES = [5, 20]
  scope :ordered, -> { order(starts_at: :asc) }

  class << self
    def create_next
      create(starts_at: next_start_date, ends_at: next_end_date)
    end

    def next_start_date
      last_end_date + 1.day
    end

    def next_end_date
      if next_start_date.day == START_DATES.last
        (next_start_date + 1.month).change(day: START_DATES.first) - 1.day
      else
        next_start_date.change(day: START_DATES.last) - 1.day
      end
    end

    def last_end_date
      ordered.last.try(:ends_at) || default_end_date
    end

    def default_end_date
      new_day = Time.now.day > START_DATES.first ? START_DATES.last : START_DATES.first
      Time.now.beginning_of_month.change(day: new_day) - 1.day
    end
  end
end
