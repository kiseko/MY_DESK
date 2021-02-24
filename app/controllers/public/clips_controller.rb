class Public::ClipsController < ApplicationController

  before_action :ensure_current_user, {except: [:index]}
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
