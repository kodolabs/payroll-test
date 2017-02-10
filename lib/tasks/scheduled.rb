namespace :scheduled do
  desc 'Create payroll if required'
  task :payroll_creation => :environment do |t|
    payout_days = PayoutSchedule.pluck(:day_of_month)

    if payout_days.include?(Date.today.day)
      last_payroll = Payroll.ordered.last
      
      if last_payroll && last_payroll.ends_at < Date.today
        PayrollsCreator.new(payout_date: Date.today).process
      end
    end
  end
end
