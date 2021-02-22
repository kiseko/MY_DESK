class Public::ScenesController < ApplicationController

  def new
    @scene = Scene.new
  end

  def create
    @scene = Scene.new(scene_params)
    if @scene.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @scene = current_user.scenes.find(params[:id])
  end

  def update
    @scene = current_user.scenes.find(params[:id])
    if @scene.update(scene_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @scene = current_user.scenes.find(params[:id])
    @scene.destroy
    redirect_to user_path(current_user)

  end


  private

  def scene_params
    params.require(:scene).permit(:image).merge(user_id: current_user.id)
  end

end
