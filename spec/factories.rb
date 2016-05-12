# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :payroll do
    starts_at 1.day.ago
    ends_at 1.day.from_now
  end

  factory :pay_date do
    pay_date { (1..31).to_a.sample }
  end

end
