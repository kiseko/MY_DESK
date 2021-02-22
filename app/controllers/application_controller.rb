class ApplicationController < ActionController::Base
  helper_method :followings_counter, :followers_counter

  def followings_counter
    current_user.followings.count
  end

  def followers_counter
    Following.where(following_user_id: current_user.id).count
  end


  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

end
