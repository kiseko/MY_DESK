class Public::FollowingsController < ApplicationController

  def create
    @user = User.find_by(unique_name: params[:user_id])
    @following = current_user.followings.build(following_user_id: @user.id)
    @following.save
  end

  def index
    @followings = current_user.followings.where.not(status: 3)
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
