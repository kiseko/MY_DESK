class Public::TimelinesController < ApplicationController

  def scene
    @following_user_ids = current_user.followings.pluck(:following_user_id)
    @scenes = Scene.where(user_id: @following_user_ids).order(id: "DESC")
  end

  def item
    @following_user_ids = current_user.followings.pluck(:following_user_id)
    @items = Item.where(user_id: @following_user_ids).order(id: "DESC")
  end

  def review
    @following_user_ids = current_user.followings.pluck(:following_user_id)
    @items = Item.where(user_id: @following_user_ids).order(id: "DESC")
  end

end
