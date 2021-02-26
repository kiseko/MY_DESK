class ApplicationController < ActionController::Base

  before_action :authenticate_user!, except: [:top, :about]


  helper_method :followings_counter,
                :followers_counter,
                :viewable_sns_link?

  def followings_counter
    following_user_ids = current_user.followings.pluck(:following_user_id)
    user = User.where(id: following_user_ids).where.not(status: 2)
    active_followings = current_user.followings.where(following_user_id: user.ids)
    return active_followings.count
  end

  def followers_counter
    followings = Following.where(following_user_id: current_user.id)
    active_followings = followings.includes(:user).where.not(users: {status: 2})
    return active_followings.count
  end

  def viewable_sns_link?(user, sns_link)
    sns_link.user_id == current_user.id ||
    sns_link.status == 0 ||
    sns_link.status == 1 && user.followings.find_by(following_user_id: current_user.id) ||
    sns_link.status == 2 && user.followings.find_by(following_user_id: current_user.id, status: 1).present?
  end


  def ensure_current_user_item_nest
    @item = Item.find_by(id: params[:item_id])
    if @item.present?
      if current_user.id != @item.user_id
        redirect_to item_path(params[:item_id])
      end
    else
      redirect_to root_path
    end
  end

  def ensure_current_user_nest
    @user = User.find_by(unique_name: params[:user_id])
    if @user.present?
      if current_user.id != @user.id
        redirect_to user_path(@user)
      end
    else
      redirect_to root_path
    end
  end

end
