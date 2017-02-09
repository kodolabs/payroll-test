# Name of class justified by the specifications (schedule can be changed in future)
class PayoutSchedule < ActiveRecord::Base
  validates :day_of_month, uniqueness: true,
                           presence: true,
                           numericality: {
                             greater_than_or_equal_to: 1,
                             less_than_or_equal_to: 28
                           }
end
