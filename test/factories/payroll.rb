FactoryGirl.define do
  factory :payroll do
    starts_at { DateTime.now }
    ends_at { DateTime.now + 1.month }
  end
end
