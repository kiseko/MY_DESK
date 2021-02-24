class ApplicationController < ActionController::Base
  helper_method :followings_counter, :followers_counter

  def followings_counter
    current_user.followings.where.not(status: 3).count
  end

  def followers_counter
    Following.where(following_user_id: current_user.id).where.not(status: 3).count
  end

end
