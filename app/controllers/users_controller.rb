class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  
  def sign_in
    @user = User.new
  end

  def login
    @user = User.login(clean_params)
    if @user
      sign_in_user(@user)
      redirect_to root_path, notice: 'succeed to login'
    else
      render :sign_in
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

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)

    if @user.update(clean_params)
      redirect_to root_path, notice: 'succeed to update'
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
