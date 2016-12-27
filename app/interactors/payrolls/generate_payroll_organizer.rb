module Payrolls
  class GeneratePayrollOrganizer
    include Interactor::Organizer

    organize GenerateStartsAtEndsAtService,
             CreatePayrollService
  end
end
