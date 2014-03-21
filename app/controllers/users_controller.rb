class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find params[:id]

    redirect_to :users, alert: "Nope!" unless @user == current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to :users, notice: "Passwort geändert"
    else
      render :edit
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password, :password_confirmation, :current_password)
  end
end
