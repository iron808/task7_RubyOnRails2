class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:user_name, :email, :password, :password_confirmation))
      if @user.save
        @user.attach_default_avatar unless @user.avatar.attached?
        session[:user_id] = @user.id
        redirect_to rooms_path, notice: "会員登録が完了しました。ようこそ"
      else
        render "new"
      end
  end

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def show_account
    @user = User.find(params[:id])
  end

  def edit_account
    @user = User.find(params[:id])
  end

  def update_account
    @user = User.find(params[:id])
    
    if params[:user][:current_password].blank?
      flash.now[:alert] = "現在のパスワードを入力してください"
      render :edit_account
      return
    end

    unless @user.authenticate(params[:user][:current_password]) 
      flash.now[:alert] = "現在のパスワードが誤っています"
      render :edit_account
      return
    end

    @user_account = params.require(:user).permit(:email, :password, :password_confirmation)

    if @user_account[:password].blank?
      @user_account.delete(:password)
      @user_account.delete(:password_confirmation)
    end

    if @user.update(@user_account)
      redirect_to show_account_user_path(@user), notice: "アカウント情報を更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit_account
    end
  end

  def show_profile
    @user = User.find(params[:id])
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def update_profile
    @user = User.find(params[:id])

    if params[:user][:user_name].blank?
      flash.now[:alert] = "ユーザー名は空白にできません"
      render :edit_profile
      return
    end


    @user_profile = params.require(:user).permit(:avatar, :user_name, :user_introduce)
    if @user_profile[:user_introduce].blank?
      @user_profile.delete(:user_introduce)
    end

    if params[:user][:avatar].present?
    @user.avatar.purge
    end

    if @user.update(@user_profile)
      redirect_to show_profile_user_path(@user), notice: "アカウント情報を更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit_profile
    end
  
  end

  def show_user_reservations
    @user = User.find(params[:id])
    @reservations = @user.reservations.includes(:room)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    reset_session
    redirect_to root_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end

end
