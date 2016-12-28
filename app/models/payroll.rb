class Payroll < ActiveRecord::Base
  scope :ordered, -> { order(starts_at: :asc) }

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :starts_at_cant_be_after_ends_at

  private

  def starts_at_cant_be_after_ends_at
    return if starts_at.nil?
    return if ends_at.nil?
    errors.add(:starts_at, 'can not be after ends_at') if starts_at > ends_at
  end

  def self.next_starts_at

  end

  def self.next_ends_at

  end
end
