require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { { auth_token: user.auth_token } }

  subject { response }

  describe "GET #index" do
    before { get :index, params }

    it { is_expected.to have_http_status(:ok) }
  end

  describe "GET #show" do
    let(:params) { super().merge(id: user.id) }

    before { get :show, params }

    it { is_expected.to have_http_status(:ok) }
  end

  describe "POST #create" do
    let(:params) { { user: attributes_for(:user) } }

    before { post :create, params }

    context 'when user params is ok' do
      it { is_expected.to have_http_status(:created) }
    end

    context 'when user params is invalid' do
      let(:params) { { user: attributes_for(:user).except(:email) } }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe "PATCH #update" do
    let(:params) { super().merge(id: user.id, user: attributes_for(:user)) }

    before { patch :update, params }

    context 'when updated params is ok' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when updated params is invalid' do
      let(:params) { super().merge(id: user.id, user: attributes_for(:user, first_name: '')) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe "GET #updated_today" do
    context 'when updated users is not empty' do
      before do
        allow(User).to receive(:updated_today).and_return([user])
        get :updated_today, params
      end

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when updated users is empty' do
      before do
        allow(User).to receive(:updated_today).and_return([])
        get :updated_today, params
      end

      it { is_expected.to have_http_status(:not_found) }
    end
  end

  describe "DELETE #destroy" do
    let(:params) { super().merge(id: user.id) }

    before { delete :destroy, params }

    it { is_expected.to have_http_status(:ok) }
  end
end
