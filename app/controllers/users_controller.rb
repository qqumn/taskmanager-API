class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    render json: user, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def updated_today
    updated_users = User.updated_today
    unless updated_users.empty?
      render json: updated_users, status: :ok
    else
      render json: 'There are no updated users for today', status: :not_found
    end
  end

  def destroy
    user.delete
    head :ok
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
