class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  PAYMENT_DAYS = [5, 20]

  def self.exists_active_period?
    exists?(['ends_at >= ?', Date.today])
  end

  def self.create_next_period
    starts_at = next_period_starts_at
    ends_at   = next_period_ends_at(starts_at)
    create(starts_at: starts_at, ends_at: ends_at)
  end

  private

  def self.next_period_starts_at
    prev_period_starts_at = maximum(:ends_at)
    return prev_period_starts_at.tomorrow if prev_period_starts_at

    nearest_payment_date(Date.today)
  end

  def self.next_period_ends_at(starts_at)
    nearest_payment_date(starts_at.tomorrow).yesterday
  end

  def self.nearest_payment_date(date_from)
    [date_from, date_from.at_beginning_of_month.next_month].each do |date|
      result = PAYMENT_DAYS.map { |d| date.change(day: d) }.detect { |d| date <= d }
      return result unless result.blank?
    end
  end
end
