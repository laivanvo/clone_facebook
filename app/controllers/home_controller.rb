class HomeController < ApplicationController
  layout "not_permission", only: [:not_permission]
  def index
    @post = Post.new
    @friends = current_user.friends
    @posts = current_user.home_posts
  end

  def not_permission
  end
end
