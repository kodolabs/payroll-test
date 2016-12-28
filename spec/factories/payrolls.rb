FactoryGirl.define do
  factory :payroll do
    starts_at { Date.today.change(day: Payroll::FIRST_HALF_STARTS_AT) }
    ends_at { Date.today.change(day: Payroll::SECOND_HALF_STARTS_AT - 1) }
  end
end
