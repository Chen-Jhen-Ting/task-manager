class UsersController < ApplicationController

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
