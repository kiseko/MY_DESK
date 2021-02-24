class Public::FollowingsController < ApplicationController

  before_action :ensure_current_user, {only: [:index]}
  def ensure_current_user
    @user = User.find_by(unique_name: params[:user_id])
    if @user.present?
      if current_user.id != @user.id
        redirect_to user_path(@user)
      end
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(unique_name: params[:user_id])
    @following = current_user.followings.build(following_user_id: @user.id)
    @following.save
  end

  def index
    @following_user_ids = current_user.followings.pluck(:following_user_id)
    @user = User.where(id: @following_user_ids).where.not(status: 2)
    @active_followings = current_user.followings.where(following_user_id: @user.ids)
  end

  def update
     @user = User.find_by(unique_name: params[:user_id])
     @following = current_user.followings.find_by(following_user_id: @user.id)
     @following.update(following_params)
  end

  def destroy
    @user = User.find_by(unique_name: params[:user_id])
    @following = current_user.followings.find_by(following_user_id: @user.id)
    @following.destroy
  end


  private

  def following_params
    params.require(:following).permit(:status)
  end

end
