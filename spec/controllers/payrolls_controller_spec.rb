RSpec.describe PayrollsController do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST create' do
    subject { post :create }

    it 'redirect to index page' do
      subject
      expect(response).to redirect_to(action: :index)
    end

    it 'create new record' do
      expect { subject }.to change { Payroll.count }.from(0).to(1)
    end
  end
end
