class PostsController < ApplicationController
  def create
    current_user.posts.create(post_params)
  end

  def post_params
    params.require(:post).permit(:text, :mode, :content, :group_id, :in_queue)
  end
end
