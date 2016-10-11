namespace :payrolls do
  desc "Creates new payroll on specified dates."
  task create_next: :environment do
    if Payroll::PAYMENT_DAYS.include? Date.today.day
      Payroll::CreateNext.new.call
      puts "Payroll created"
    else
      puts "Skipping this day"
    end
  end
end
