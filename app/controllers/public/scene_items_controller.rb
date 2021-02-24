class Public::SceneItemsController < ApplicationController

  before_action :ensure_current_user
  def ensure_current_user
    @scene = Scene.find_by(id: params[:scene_id])
    if @scene.present?
      @user = User.find(@scene.user_id)
      if current_user.id != @user.id
        redirect_to user_path(@user)
      end
    else
      redirect_to root_path
    end
  end


  def new
    @scene_item = SceneItem.new
    @scene = Scene.find(params[:scene_id])
    @items = current_user.items.order(updated_at: "DESC")
  end

  def create
    @scene_item = SceneItem.new(scene_item_params)
    @scene_item.scene_id = params[:scene_id]
    if @scene_item.save
      redirect_to user_path(current_user)
    else
      @scene = Scene.find(params[:scene_id])
      @items = current_user.items
      render :new
    end

  end

  def destroy
     @scene_item = SceneItem.find(params[:id])
     @scene_item.destroy
     redirect_to user_path(current_user)
  end


  private

  def scene_item_params
    params.require(:scene_item).permit(:item_id)
  end

end
