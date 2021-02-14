class Public::UsersController < ApplicationController

  def show
    @user = User.find_by(unique_name: params[:id])
    @scenes = @user.scenes
    @scene_counter = 0
  end

  def edit
  end

  def update
  end

  def leave
  end

  def resign
  end


  private

  def user_params
    params.require(:user).permit(:unique_name, :hundle_name, :email, :encrypted_password, :image, :introduction, :status)
  end
end
