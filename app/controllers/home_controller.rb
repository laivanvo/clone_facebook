class HomeController < ApplicationController
  def index
    @post = Post.new
    @friends = current_user.friends
    @posts = current_user.home_posts
  end
end
