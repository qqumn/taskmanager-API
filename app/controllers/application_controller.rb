class ApplicationController < ActionController::Base
  before_action :authenticate_user

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authenticate_user
    render json: { errors: ['Authentication token does not provided or invalid'] }, status: 401 unless current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(auth_token: params[:auth_token]) if params[:auth_token]
  end

  def record_not_found
    render json: 'Record not found', status: :not_found
  end
end
