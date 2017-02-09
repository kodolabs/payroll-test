# == Schema Information
#
# Table name: payroll_days
#
#  id         :integer          not null, primary key
#  day        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PayrollDay < ActiveRecord::Base

  # 1 <= day <= 28 !!!

  def self.days
    PayrollDay.pluck(:day).sort
  end
end
