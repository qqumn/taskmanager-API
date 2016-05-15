class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    if user && user.authenticate(session_params[:password])
      render json: user, status: :created
    else
      render json: { errors: ['Email or password is invalid'] }, status: :unprocessable_entity
    end
  end

  private

  def user
    @user ||= User.find_by(email: session_params[:email])
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
