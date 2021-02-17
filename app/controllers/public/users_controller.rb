class Public::UsersController < ApplicationController

  def show
    @user = User.find_by(unique_name: params[:id])
    @instagram_link = @user.instagram_link
    @twitter_link = @user.twitter_link
    @scenes = @user.scenes
    @scene_counter = 0
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :show
    end
  end

  def link
    @user = current_user
    @new_instagram_link = InstagramLink.new
    @instagram_link = @user.instagram_link
    @new_twitter_link = TwitterLink.new
    @twitter_link = @user.twitter_link
  end

  def leave
  end

  def resign
  end


  private

  def user_params
    params.require(:user).permit(:unique_name, :hundle_name, :email, :encrypted_password, :image, :introduction, :status)
  end
end
