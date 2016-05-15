require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { { auth_token: user.auth_token } }
  let(:project) { create(:project) }

  subject { response }

  describe 'POST #create' do
    let(:params) { super().merge(comment: attributes_for(:comment), commentable_type: 'Project', commentable_id: project.id) }

    before { post :create, params }

    context 'when comment params is ok' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when comment params is not valid' do
      let(:params) { super().merge(comment: attributes_for(:comment, body: ''), commentable_type: 'Project', commentable_id: project.id) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PATCH #update' do
    let(:comment) { create(:comment) }
    let(:params) { super().merge(comment: attributes_for(:comment), commentable_type: 'Project', commentable_id: project.id, id: comment.id) }

    before { post :create, params }

    context 'when comment params is ok' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when comment params is not valid' do
      let(:params) { super().merge(comment: attributes_for(:comment, body: ''), commentable_type: 'Project', commentable_id: project.id) }

      it { is_expected.to have_http_status(:unprocessable_entity)}
    end
  end

end
