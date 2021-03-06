class Public::ClipsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
    @clip = @item.clips.build(user_id: current_user.id)
    @clip.save
  end

  def index
    @user = User.find_by(unique_name: params[:user_id])
    if @user.present?
      @clips = @user.clips.includes(item: :user).where.not(users: {status: 2}).order(id: "DESC").page(params[:page]).per(8)
    end
  end

  def destroy
    @item = Item.find(params[:item_id])
    @clip = @item.clips.find_by(user_id: current_user.id)
    @clip.destroy
  end

end
