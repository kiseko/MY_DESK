class Public::TimelinesController < ApplicationController

  def scene
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @scenes = Scene.where(user_id: @following_user_ids).includes(:user).where(users: {status: 0}).order(id: "DESC")
  end

  def item
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @items = Item.where(user_id: @following_user_ids).includes(:user).where(users: {status: 0}).order(id: "DESC")
  end

  def review
    @following_user_ids = current_user.followings.where.not(status: 2).pluck(:following_user_id)
    @review_item_ids = Review.pluck(:item_id)
    @items = Item.where(id: @review_item_ids, user_id: @following_user_ids).includes(:user).where(users: {status: 0}).order(id: "DESC")
  end

end
