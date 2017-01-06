namespace :cron do
  task create_new_payroll_for_period: :environment do
    Services::PayrollAutoCreate.new.process
  end
end
