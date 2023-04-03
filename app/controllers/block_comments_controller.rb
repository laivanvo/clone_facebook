class BlockCommentsController < ApplicationController
  before_action :check_create_permission, only: [:create]
  before_action :check_destroy_permission, only: [:destroy]

  def create
    @block = @post.block_comments.new block_params
    if @block.save
      render :create
    else
      flash[:error] = @block.errors.full_messages
      render_post_error(block_params[:post_id])
    end
  end

  def destroy
    if @block.destroy
      @new_block = { post_id: @block.post_id, user_id: @block.user_id }
      render :destroy
    else
      flash[:error] = @block.errors.full_messages
      render_post_error(@block.post_id)
    end
  end

  private

  def check_create_permission
    @post = current_user.posts.find_by(id: block_params[:post_id])
    if @post.nil?
      flash[:error] = t "error.not_permission"
    elsif current_user.id == block_params[:user_id]
      flash[:error] = t ".can_not_block_yourself"
    end
    if flash[:error]
      render_post_error(block_params[:post_id])
    end
  end

  def check_destroy_permission
    @block = BlockComment.find_by(id: params[:id])
    if @block.nil?
      flash[:success] = t "error.not_permission"
      redirect_to not_permission_path
    elsif current_user.posts.find_by(id: @block.post_id).nil?
      flash[:success] = t "error.not_permission"
      render_post_error(block_params[:post_id])
    end
  end

  def render_post_error(post_id)
    render template: "posts/error",
           locals: { post_id: post_id }
  end

  def block_params
    params.require(:block).permit(:post_id, :user_id)
  end
end
