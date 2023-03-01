class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = current_user.posts.new
    @posts = Post.all.order('created_at')
    @senders = current_user.senders
  end
end
