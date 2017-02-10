[5, 20].each do |day_of_month|
  PayoutSchedule.create! day_of_month: day_of_month
end
