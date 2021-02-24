class ApplicationController < ActionController::Base
  helper_method :followings_counter, :followers_counter

  def followings_counter
    @following_user_ids = current_user.followings.pluck(:following_user_id)
    @user = User.where(id: @following_user_ids).where.not(status: 2)
    @active_followings = current_user.followings.where(following_user_id: @user.ids)
    return @active_followings.count
  end

  def followers_counter
    @followings = Following.where(following_user_id: current_user.id)
    @active_followings = @followings.includes(:user).where.not(users: {status: 2})
    return @active_followings.count
  end

end
