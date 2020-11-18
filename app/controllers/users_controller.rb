class UsersController < ApplicationController

  def sign_in
    @user = User.new
  end

  def login
    user = User.login(clean_params)
    if user
      sign_in_user(user)
      redirect_to root_path, notice: 'succeed to login'
    else
      render sign_in_users_path, notice: "Please input correct email and password"
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

  def sign_out
    sign_out_user
    redirect_to root_path, notice: 'sign out!'
  end

  private

  def clean_params
    params.require(:user).permit(:email, :name, :password)
  end

  def sign_in_user(user)
    session[:user_token] = user.id
  end

  def sign_out_user
    session[:user_token] = nil
  end

end
