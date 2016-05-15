require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:password) { '12341234' }
  let(:user) { create(:user, password: password) }
  let(:params) { { user: { email: user.email, password: user.password } } }

  subject { response }

  describe 'POST #create' do
    before { post :create, params }

    context 'when params is ok' do
      it { is_expected.to have_http_status(:created) }
    end

    context 'when params is invalid' do
      let(:params) { { user: { email: user.email, password: '' } } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
