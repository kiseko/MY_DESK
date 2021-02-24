class Public::ClipsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    @clip = @item.clips.build(user_id: current_user.id)
    @clip.save
  end

  def index
    @clips = current_user.clips.order(id: "DESC")
  end

  def destroy
    @item = Item.find(params[:item_id])
    @clip = @item.clips.find_by(user_id: current_user.id)
    @clip.destroy
  end

end
