require 'rails_helper'

describe Payroll::CreateNext do
  subject { described_class }

  it 'should work' do
    # 1
    expect(Payroll.count).to eq 0
    res = subject.new.call
    expect(res.starts_at).to eq DateTime.new(2016, 1, 5)
    expect(res.ends_at).to eq DateTime.new(2016, 1, 19)
    # 2
    expect(Payroll.count).to eq 1
    res = subject.new.call
    expect(res.starts_at).to eq DateTime.new(2016, 1, 20)
    expect(res.ends_at).to eq DateTime.new(2016, 2, 4)
    # 3
    expect(Payroll.count).to eq 2
    res = subject.new.call
    expect(res.starts_at).to eq DateTime.new(2016, 2, 5)
    expect(res.ends_at).to eq DateTime.new(2016, 2, 19)
    # Check with another days
    params = {days: [15]}
    # 4
    expect(Payroll.count).to eq 3
    res = subject.new(params).call
    expect(res.starts_at).to eq DateTime.new(2016, 2, 20)
    expect(res.ends_at).to eq DateTime.new(2016, 3, 14)
    # 5
    expect(Payroll.count).to eq 4
    res = subject.new(params).call
    expect(res.starts_at).to eq DateTime.new(2016, 3, 15)
    expect(res.ends_at).to eq DateTime.new(2016, 4, 14)
    # 6
    expect(Payroll.count).to eq 5
    res = subject.new(params).call
    expect(res.starts_at).to eq DateTime.new(2016, 4, 15)
    expect(res.ends_at).to eq DateTime.new(2016, 5, 14)
    # Check with another days
    params = {days: [1, 10, 20]}
    # 7
    expect(Payroll.count).to eq 6
    res = subject.new(params).call
    expect(res.starts_at).to eq DateTime.new(2016, 5, 15)
    expect(res.ends_at).to eq DateTime.new(2016, 5, 19)
    # 8
    expect(Payroll.count).to eq 7
    res = subject.new(params).call
    expect(res.starts_at).to eq DateTime.new(2016, 5, 20)
    expect(res.ends_at).to eq DateTime.new(2016, 5, 31)
    # 9
    expect(Payroll.count).to eq 8
    res = subject.new(params).call
    expect(res.starts_at).to eq DateTime.new(2016, 6, 1)
    expect(res.ends_at).to eq DateTime.new(2016, 6, 9)
  end
end
