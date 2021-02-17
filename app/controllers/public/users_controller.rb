class Public::UsersController < ApplicationController

  def show
    @user = User.find_by(unique_name: params[:id])
    @scenes = @user.scenes
    @scene_counter = 0
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :show
    end
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
