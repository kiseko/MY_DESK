class Public::InstagramLinksController < ApplicationController

  before_action :ensure_current_user
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
    @user = current_user
    @new_instagram_link =  InstagramLink.new(instagram_link_params)
    @new_instagram_link.user_id = @user.id
    if @new_instagram_link.save
      redirect_to user_path(@user)
    else
      @new_twitter_link = TwitterLink.new
      @twitter_link = @user.twitter_link
      render template: "public/users/link"
    end
  end

  def update
    @user = current_user
    @instagram_link = @user.instagram_link
    if  @instagram_link.update(instagram_link_params)
      redirect_to user_path(@user)
    else
      @new_twitter_link = TwitterLink.new
      @twitter_link = @user.twitter_link
      render template: "public/users/link"
    end
  end

  def destroy
    @user = current_user
    @instagram_link = @user.instagram_link
    @instagram_link.destroy
    redirect_to user_path(@user)
  end


  private

  def instagram_link_params
    params.require(:instagram_link).permit(:url, :status)
  end

end
