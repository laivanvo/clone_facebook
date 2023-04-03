class HomeController < ApplicationController
  layout "not_permission", only: [:not_permission]

  def index
    @post = current_user.posts.new
    @new_comment = current_user.comments.new
    @posts = current_user.home_posts.includes(:comments, :reactions).page
  end

  def not_permission
  end
end
