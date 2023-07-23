class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to new_event_path
    else
      flash[:alert] = 'Failed to register user'
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
