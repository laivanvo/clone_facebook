class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @user = User.find_by(token: params[:token])
    if user_signed_in?
      @is_mine = current_user.id == @user.id
      @post = current_user.posts.new
      @relation = current_user.relation @user.id
    end
  end
end
