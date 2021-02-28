class Public::HomesController < ApplicationController

  def top
    @scene_user_ids = Scene.pluck(:user_id)
    @users = User.where(id: @scene_user_ids).order(id: "DESC").page(params[:page]).per(8)
  end

  def about
  end

end
