class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  FIRST_DATE = 5
  SECOND_DATE = 20

  def self.make

    if last_payroll = Payroll.all.last
      if last_payroll.ends_at.day.between?(FIRST_DATE, SECOND_DATE)
        ends_at_day = FIRST_DATE - 1
        ends_at_month = last_payroll.ends_at.next_month.month
        ends_at_year = last_payroll.ends_at.next_month.year
      else
        ends_at_day = SECOND_DATE - 1
        ends_at_month = last_payroll.ends_at.month
        ends_at_year = last_payroll.ends_at.year
      end
    else
      ends_at_month = 1
      ends_at_year = Time.now.year
      ends_at_day = SECOND_DATE - 1
    end

    starts_at = starts_at_from_payroll(last_payroll)

    Payroll.new(
      starts_at: Date.new(starts_at[:year], starts_at[:month], starts_at[:day]),
      ends_at: Date.new(ends_at_year, ends_at_month, ends_at_day)
    )

  end

  private

  def self.starts_at_from_payroll(last_payroll)
    if last_payroll
      {
        year: last_payroll.ends_at.tomorrow.year,
        month: last_payroll.ends_at.tomorrow.month,
        day: last_payroll.ends_at.tomorrow.day
      }
    else
      {
        year: Time.now.year,
        month: 1,
        day: FIRST_DATE
      }
    end
  end

end
