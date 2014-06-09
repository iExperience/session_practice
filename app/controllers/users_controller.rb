class UsersController < ApplicationController
  def index
    @users = User.all
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

  def show
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      flash[:error] = "You must be signed in to view that page"
      redirect_to "/"
    end
  end

  def sign_in
    @user = User.where(email: params[:email],
      password: params[:password]).first
    if @user
      session[:user_id] = @user.id
      flash[:success] = "User found"
    else
      flash[:error] = "User not found"
    end
    redirect_to "/"
  end

  def sign_out
    session[:user_id] = nil
    redirect_to "/"
  end
end
