class Public::UsersController < ApplicationController

  def show
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
