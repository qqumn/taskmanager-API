require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { { auth_token: user.auth_token } }

  subject { response }

  describe 'GET #index' do
    before { get :index, params }

    it { is_expected.to have_http_status(:ok) }
  end
end
