class Public::TwitterLinksController < ApplicationController

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
    @new_twitter_link =  TwitterLink.new(twitter_link_params)
    @new_twitter_link.user_id = @user.id
    if @new_twitter_link.save
      redirect_to user_path(@user)
    else
      @new_instagram_link = InstagramLink.new
      @instagram_link = @user.instagram_link
      render template: "public/users/link"
    end
  end

  def update
    @user = current_user
    @twitter_link = @user.twitter_link
    if  @twitter_link.update(twitter_link_params)
      redirect_to user_path(@user)
    else
      @new_instagram_link = InstagramLink.new
      @instagram_link = @user.instagram_link
      render template: "public/users/link"
    end
  end

  def destroy
    @instagram_link = current_user.instagram_link
    @instagram_link.destroy
    redirect_to user_path(@user)
  end


  private

  def twitter_link_params
    params.require(:twitter_link).permit(:url, :status)
  end

end
