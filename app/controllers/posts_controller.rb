class PostsController < ApplicationController
  before_action :authenticate_user!
  def create
    current_user.post.create(post_params)
  end

  def post_params
    params.require(:post).permit(:text, :mode, :content)
  end
end
