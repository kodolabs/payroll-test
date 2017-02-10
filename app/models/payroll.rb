# == Schema Information
#
# Table name: payrolls
#
#  id         :integer          not null, primary key
#  starts_at  :datetime
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  class <<self
    # add new payroll according to schedule
    def add
      last = ordered.last
      last_date = last.nil? ? Date.today : last.ends_at
      new_starts_at = last_date + 1.day
      new_ends_at = calc_ends_at(new_starts_at)
      create(starts_at: new_starts_at, ends_at: new_ends_at)
    end

    def auto_adder
      add if PayrollDay.days.include?(Date.today.day)
    end

    private

    # calculate ends_at for starts_at
    def calc_ends_at(starts_at)
      days = PayrollDay.days
      next_date = nil
      days.each do |day|
        if day > starts_at.day
          next_date = starts_at.change(day: day)
          break
        end
      end
      next_date = (starts_at + 1.month).change(day: days.min) if next_date.nil?
      next_date - 1.day
    end
  end

end
