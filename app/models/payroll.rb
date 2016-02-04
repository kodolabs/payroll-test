class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }


  class << self

    def no_payrolls?
      all.length == 0
    end

    def last_payroll
      last.ends_at
    end


    def next_payroll(last_payroll)
      if last_payroll.strftime('%d') =='19'
        fourth = (last_payroll + 1.month).strftime('4 %b %Y')
        create(starts_at: payroll_day(20), ends_at: fourth)
      else
        create(starts_at: payroll_day(5), ends_at: payroll_day(19))
      end
    end


    private

    def payroll_day(day)
      last_payroll.strftime("#{day} %b %Y")
    end

  end
end