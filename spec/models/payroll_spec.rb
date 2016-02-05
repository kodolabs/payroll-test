require 'rails_helper'

RSpec.describe Payroll, type: :model do
  describe '.create_next' do
    context 'when no payrolls exist' do
      before { Timecop.freeze(Date.parse('1 feb 2016')) }
      after { Timecop.return }

      it 'should use current month' do
        res = Payroll.create_next
        expect(res.starts_at).to eq Date.parse('5 feb 2016')
        expect(res.ends_at).to eq Date.parse('19 feb 2016')
      end
    end

    context 'when there is a payroll' do
      before do
        Timecop.freeze(Date.parse('1 feb 2016'))
        Payroll.create_next
        Timecop.return
      end

      it 'should use last payroll data' do
        res = Payroll.create_next
        expect(res.starts_at).to eq Date.parse('20 feb 2016')
        expect(res.ends_at).to eq Date.parse('4 mar 2016')
      end
    end

    context 'when settings changed' do
      it 'should use new settings'
    end
  end
end
