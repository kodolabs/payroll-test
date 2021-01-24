# frozen_string_literal: true

class CreatePayrollQuery
  DEFAULT_START_DATE = DateTime.new(Time.now.year, Time.now.month, 5)
  DEFAULT_END_DATE   = DateTime.new(Time.now.year, Time.now.month, 19)

  def initialize(params)
    @params = params
  end

  def invoke
    last_pay_roll = Payroll.last

    if last_pay_roll.blank?
      first_pay_order = create_new_pay_roll(DEFAULT_START_DATE, DEFAULT_END_DATE)
      check_pay_roll(first_pay_order)
    else
      last_pay_roll_end_date = DateTime.parse(last_pay_roll.ends_at.to_s)

      new_pay_roll =
        if @params[:start_date].present? && @params[:end_date].present?
          payroll_with_specific_date(@params)
        else
          payroll_with_default_dates(last_pay_roll_end_date)
        end

      check_pay_roll(new_pay_roll)
    end
  end

  private

  def payroll_with_default_dates(last_pay_roll_end_date)
    start_date = DateTime.new(
      last_pay_roll_end_date.year,
      last_pay_roll_end_date.month,
      last_pay_roll_end_date.day == 4 ? 5 : 20
    )

    end_date   = start_date + 15.days
    end_date   =
      if end_date.month != start_date.month
        DateTime.new(
          end_date.year,
          end_date.month,
          end_date.day.in?((4..19).to_a) ? 4 : 19
        )
      else
        DateTime.new(
          end_date.year,
          end_date.month,
          end_date.day.in?((4..19).to_a) ? 4 : 19
        )
      end
    create_new_pay_roll(start_date, end_date)
  end

  def payroll_with_specific_date(params)
    start_date = params[:start_date]
    end_date   = params[:end_date]

    create_new_pay_roll(start_date, end_date)
  end

  def create_new_pay_roll(start_date, end_date)
    Payroll.create(starts_at: start_date, ends_at: end_date)
  end

  def check_pay_roll(record)
    raise('Pay roll creation error') unless record.persisted?
  end
end
