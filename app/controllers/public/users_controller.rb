class Public::UsersController < ApplicationController

  before_action :ensure_current_user, {except: [:show, :search]}
  def ensure_current_user
    @user = User.find_by(unique_name: params[:id])
    if @user.present?
      if current_user.id != @user.id
        redirect_to user_path(@user)
      end
    else
      redirect_to root_path
    end
  end


  def show
    @user = User.find_by(unique_name: params[:id])
    if @user.present?
      @instagram_link = @user.instagram_link
      @twitter_link = @user.twitter_link
      @scenes = @user.scenes
      @scene_counter = 0
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @old_unique_name = @user.unique_name
    if @user.update(user_params)
      redirect_to user_path(@user)
    elsif !params[:user][:email].nil?
      render :mail_setting
    elsif params[:user][:unique_name].blank?
      redirect_to edit_user_path(@old_unique_name)
      flash[:alert] = "--ユーザーIDが空のため更新できませんでした--"
    else
      render :edit
    end
  end

  def link
    @user = current_user
    @new_instagram_link = InstagramLink.new
    @instagram_link = @user.instagram_link
    @new_twitter_link = TwitterLink.new
    @twitter_link = @user.twitter_link
  end

  def followers
    @followings = Following.where(following_user_id: current_user.id)
    @active_followings = @followings.includes(:user).where.not(users: {status: 2}).order(id: "DESC").page(params[:page]).per(10)
  end

  def mail_setting
    @user = current_user
  end

  def leave
    @user = current_user
  end

  def resign
    @user = current_user
    @user.update(status: 2)
    reset_session
    redirect_to root_path
  end

  def search
     @users = User.search(params[:search]).where(status: 0).order(updated_at: "DESC").page(params[:page]).per(8)
     @search_value = (params[:search])
  end


  private

  def user_params
    params.require(:user).permit(:unique_name, :hundle_name, :email, :image, :introduction, :status)
  end
end
