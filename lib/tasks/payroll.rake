namespace :payroll do
  desc 'generate payroll'
  task generate: :environment do
    last_payroll = Payroll.last

    next if last_payroll && last_payroll.ends_at > Date.today

    new_payroll = generate_payroll

    if new_payroll && new_payroll.save
      Rails.logger.info "#{Date.today} - New payroll was successfully created"
    else
      Rails.logger.error "#{Date.today} - Error: #{new_payroll.errors.full_messages}"
    end
  end

  private

  def generate_payroll
    PayrollService.new.generate
  end
end
