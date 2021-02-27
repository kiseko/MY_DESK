class Public::ClipsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    @clip = @item.clips.build(user_id: current_user.id)
    @clip.save
  end

  def index
    @clips = current_user.clips.includes(item: :user).where.not(users: {status: 2}).order(id: "DESC").page(params[:page]).per(8)
  end

  def destroy
    @item = Item.find(params[:item_id])
    @clip = @item.clips.find_by(user_id: current_user.id)
    @clip.destroy
  end

end
