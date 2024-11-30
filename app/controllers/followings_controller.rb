class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:id])
    current_user.followed_users << user unless current_user.followed_users.include?(user)
    redirect_to root_path, notice: "You are now following #{user.name}"
  end

  def destroy
    user = User.find(params[:id])
    current_user.followed_users.delete(user)
    redirect_to root_path, notice: "You are no longer following #{user.name}"
  end
end
