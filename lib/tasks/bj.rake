namespace :bj do
  desc 'Start Payroll auto adder'
  task :paa => :environment do |t|
    Payroll.auto_adder
  end
end