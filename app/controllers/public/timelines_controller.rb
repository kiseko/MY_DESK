class Public::TimelinesController < ApplicationController

  def scene
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @scenes = Scene.where(user_id: @following_user_ids).includes(:user).where(users: {status: 0}).order(id: "DESC").page(params[:page]).per(8)
  end

  def item
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @active_users = User.where(id: @following_user_ids, status: 0)
    @scene_items = SceneItem.includes(:item).where(items: {user_id: @active_users.ids}).order(id: "DESC").page(params[:page]).per(8)
  end

  def review
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @active_users = User.where(id: @following_user_ids, status: 0)
    @active_items =Item.where(user_id: @active_users.ids)
    @reviews = Review.includes([item: :scene_items]).where(scene_items: {item_id: @active_items.ids}).order(id: "DESC").page(params[:page]).per(8)
  end

end
