class Public::ScenesController < ApplicationController

  def new
    @user = current_user
    @scene = Scene.new
  end

  def create
    @scene = Scene.new(scene_params)
    if @scene.save
      redirect_to user_path(current_user)
    else
      @user = current_user
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def scene_params
    params.require(:scene).permit(:image).merge(user_id: current_user.id)
  end

end
