class SessionsController < ApplicationController

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def new

  end

  def create
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect_to rooms_path, notice: "ログインに成功しました"
  else
    flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
    render :new 
  end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
  
end
