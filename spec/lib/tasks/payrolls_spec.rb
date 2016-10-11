require 'rails_helper'
require 'rake'

describe 'payrolls namespace rake tasks' do
  before :all do
    Rake.application.rake_require "tasks/payrolls"
    Rake::Task.define_task(:environment)
  end

  describe 'payrolls:create_next' do
    let :run_task do
      Rake::Task['payrolls:create_next'].reenable
      Rake.application.invoke_task 'payrolls:create_next'
    end

    it 'should create a payroll on defined days' do
      expect(Date).to receive(:today).and_return(Date.new(2016, 1, 5))
      expect{run_task}.to change{Payroll.count}.by(1)
    end

    it 'should not create a payroll on another days' do
      expect(Date).to receive(:today).and_return(Date.new(2016, 1, 7))
      expect{run_task}.not_to change{Payroll.count}
    end
  end
end
