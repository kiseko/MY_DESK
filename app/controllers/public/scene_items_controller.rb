class Public::SceneItemsController < ApplicationController

  def new
    @scene_item = SceneItem.new
    @scene = Scene.find(params[:scene_id])
    @items = current_user.items
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
