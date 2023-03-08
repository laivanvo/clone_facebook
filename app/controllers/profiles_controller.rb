class ProfilesController < ApplicationController
  def index
  end

  def show
    @user = User.find params[:id]
    @friends = current_user.friends
    @relation = current_user.relation params[:id]
    @posts = @user.posts
    @common_friends = current_user.common_friends params[:id]
  end
end
