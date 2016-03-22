class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  FIRST_DATE = 5
  SECOND_DATE = 20

  def self.make

    if last_payroll = Payroll.all.last
      if last_payroll.ends_at.day.between?(FIRST_DATE, SECOND_DATE)
        ends_at = FIRST_DATE - 1
        ends_at_month = last_payroll.ends_at.next_month.month
        ends_year = last_payroll.ends_at.next_month.year
      else
        ends_at = SECOND_DATE - 1
        ends_at_month = last_payroll.ends_at.month
        ends_year = last_payroll.ends_at.year
      end
    else
      ends_at_month = 1
      ends_year = Time.now.year
      ends_at = SECOND_DATE - 1
    end

    Payroll.new(
      starts_at: Date.new((last_payroll && last_payroll.ends_at.tomorrow.year) || Time.now.year,
                          (last_payroll && last_payroll.ends_at.tomorrow.month) || 1,
                          (last_payroll && last_payroll.ends_at.tomorrow.day) || FIRST_DATE),
      ends_at: Date.new(ends_year, ends_at_month, ends_at)
    )

  end

end
