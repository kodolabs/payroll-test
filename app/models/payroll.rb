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
        twentieth = (last_payroll).strftime('20 %b')
        fourth = (last_payroll + 1.month).strftime('4 %b')
        create(starts_at: twentieth, ends_at: fourth) #TODO
        p '20-4'
      else
        fifth = (last_payroll + 1.month).strftime('5 %b')
        nineteenth = (last_payroll + 1.month).strftime('19 %b')
        create(starts_at: fifth, ends_at: nineteenth)
        p '5-19'
      end
    end

  end
end