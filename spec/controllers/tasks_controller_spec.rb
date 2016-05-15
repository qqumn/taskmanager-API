require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { { auth_token: user.auth_token } }
  let(:task) { create(:task) }
  let(:project)  { task.project }

  subject { response }

  describe 'GET #index' do
    let(:params) { super().merge(project_id: project.id) }

    before { get :index, params }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'GET #show' do
    let(:params) { super().merge(project_id: project.id, id: task.id) }

    before { get :show, params }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'POST #create' do
    let(:executor) { create(:user) }
    let(:task_params) { { task: attributes_for(:task) }.merge(executor_id: executor.id) }
    let(:params) { super().merge(project_id: project.id, task: task_params ) }

    before { post :create, params }

    context 'when comment params is ok' do
      it { is_expected.to have_http_status(:created) }
    end

    context 'when comment params is invalid' do
      let(:params) { super().merge(id: user.id, task: attributes_for(:task, name: '')) }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PATCH #update' do
    let(:executor) { create(:user) }
    let(:task_params) { { task: attributes_for(:task) }.merge(executor_id: executor.id) }
    let(:params) { super().merge(project_id: project.id, task: task_params, id: task.id ) }

    before { patch :update, params }

    context 'when updated params is ok' do
      it { is_expected.to have_http_status(:ok) }
    end

    # context 'when updated params is invalid' do
    #   let(:task_params) { { task: attributes_for(:task, name: ' ') }.merge(executor_id: executor.id) }
    #   let(:params) { super().merge(project_id: project.id, task: task_params, id: task.id) }
    #   it { is_expected.to have_http_status(:unprocessable_entity) }
    # end
  end

  describe 'DELETE #destroy' do
    let(:params) { super().merge(project_id: project.id, id: task.id) }

    before { delete :destroy, params }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'GET #assign_me' do
    let(:params) { super().merge(project_id: project.id, id: task.id ) }

    before { get :assign_me, params }

    it { is_expected.to have_http_status(:ok)  }
  end

  describe 'PATCH #marked_done' do
    context 'when task is found' do
      let(:task) { create(:task, executor_id: user.id) }
      let(:params) { super().merge(project_id: project.id, id: task.id) }

      before { get :marked_done, params }

      it { is_expected. to have_http_status(:ok) }
    end

    context 'when task is not found' do
      let(:params) { super().merge(project_id: project.id, id: task.id) }

      before { get :marked_done, params }

      it { is_expected. to have_http_status(:not_found) }
    end

  end

end
