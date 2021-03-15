class Public::HomesController < ApplicationController

  def top
    @scene_user_ids = Scene.pluck(:user_id)
    @users = User.where(id: @scene_user_ids, status: 0).order(id: "DESC").page(params[:page]).per(12)
  end

  def about
  end

end
