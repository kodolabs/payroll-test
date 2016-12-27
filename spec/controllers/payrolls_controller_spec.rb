RSpec.describe PayrollsController do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST create' do
    it 'renders the index template' do
      post :create
      expect(response).to redirect_to(action: :index)
    end
  end
end
