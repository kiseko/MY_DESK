class Public::TimelinesController < ApplicationController

  def scene
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @scenes = Scene.where(user_id: @following_user_ids).includes(:user).where(users: {status: 0}).order(id: "DESC")
  end

  def item
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @active_user_ids = User.where(id: @following_user_ids, status: 0).ids
    @scene_items = SceneItem.includes(:item).where(items: {user_id: @active_user_ids}).order(id: "DESC")
  end

  def review
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @active_user_ids = User.where(id: @following_user_ids, status: 0).ids
    @reviews = Review.includes(:item).where(items: {user_id: @active_user_ids}).order(id: "DESC")
  end

end
