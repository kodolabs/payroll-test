class PayDate < ActiveRecord::Base

  scope :ordered, -> { order(pay_date: :asc) }

  validates_numericality_of :pay_date, greater_than_or_equal_to: 1, less_than_or_equal_to: 31
  validates_uniqueness_of :pay_date
  validates_presence_of :pay_date

  after_validation :check_pay_date

  private

  def check_pay_date

    if self.pay_date.to_i < 2
      self.is_first = true
      self.pay_date = 1
    elsif pay_date >=28
      self.is_last = true
      self.pay_date = 31
    end
  end

end
