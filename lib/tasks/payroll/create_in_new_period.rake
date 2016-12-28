namespace :payroll do
  task create_in_new_period: :environment do
    if [Payroll::FIRST_HALF_STARTS_AT, Payroll::SECOND_HALF_STARTS_AT].include?(Date.today.day)
      Payrolls::GeneratePayrollOrganizer.call
    end
  end
end
