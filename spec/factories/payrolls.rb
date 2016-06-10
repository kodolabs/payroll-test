FactoryGirl.define do
  factory :payroll do
    trait :starts_today do
      starts_at { Date.today }
      ends_at   { 1.days.from_now }
    end

    trait :starts_in_the_future do
      starts_at { 2.days.from_now }
      ends_at   { 3.days.from_now }
    end

    trait :starts_in_the_past do
      starts_at { 2.days.ago }
      ends_at   { 3.days.ago }
    end
  end
end