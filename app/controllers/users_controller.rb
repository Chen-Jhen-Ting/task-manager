class UsersController < ApplicationController

  def sign_in
    @user = User.new
  end

  def login
    user = User.login(clean_params)
    if user
      redirect_to root_path, notice: 'succeed to login'
    else
      redirect_to sign_in_users_path, notice: "Please input correct email and password"
    end
  end

  def sign_up
    @user = User.new
  end

  def create
    @user = User.new(clean_params)
    if @user.save
      redirect_to root_path, notice: 'succeed to sign up'
    else
      render :sign_up
    end
  end

  private

  def clean_params
    params.require(:user).permit(:email, :name, :password)
  end
end
