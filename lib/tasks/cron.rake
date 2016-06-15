namespace :cron do
  task create_next_payroll_period: :environment do
    Payroll.create_next_period unless Payroll.exists_active_period?
  end
end
