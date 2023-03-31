class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :check_comment_ability, only: %i[create update]
  before_action :set_comment, only: %i[update destroy]

  def index
    post = Post.find_by(id: params[:post_id])
    comment = Comment.find_by(id: params[:comment_id])
    if post
      @comments = post.comments.low.page(params[:page])
      @tag_id = "comment_post_#{post.id}"
    else
      @comments = comment.comments.page(params[:page])
      @tag_id = "rep_comment_#{comment.id}"
    end
  end

  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      @new_comment = current_user.comments.new
      @tag_id = @pre_comment ? "#new_rep_comment_#{@pre_comment.id}" : "#new_comment_post_#{@post.id}"
      @count_comment = @pre_comment ? @pre_comment.comments.count : @post.comments.count
      render :create
    else
      flash[:error] = @comment.errors.messages
      render_post_error(comment_params[:post_id])
    end
  end

  def update
    if @comment.update comment_params
      @new_comment = current_user.comments.new
      render :update
    else
      flash[:error] = @comment.errors.messages
      render_post_error(comment_params[:post_id])
    end
  end

  def destroy
    if @comment.destroy
      @count_comment = @pre_comment ? @pre_comment.comments.count : @post.comments.count
      render :destroy
    else
      flash[:error] = @comment.errors.messages
      render_post_error(@comment.post_id)
    end
  end

  private

  def check_comment_ability
    @post = Post.find_by(id: comment_params[:post_id])
    @pre_comment = @post.comments.find_by(id: comment_params[:comment_id])
    block = current_user.be_blocked(comment_params[:post_id])
    if !@post.comment_flag
      flash[:error] = "bài viết đã tắt tính năng bình luận"
    elsif block
      flash[:error] = "bạn đã bị chặn bình luận"
    elsif @pre_comment&.high?
      flash[:error] = "bình luận đã ở mức cao nhất"
    end
    if flash[:error]
      render_post_error(comment_params[:post_id])
    end
  end

  def set_comment
    @comment = current_user.comments.find_by(id: params[:id])
    if @comment.nil?
      flash[:error] = "bạn không có quyền thao tác"
      render_post_error(comment_params[:post_id])
    end
  end

  def render_post_error(post_id)
    render template: "posts/error",
           locals: { post_id: post_id }
  end

  def comment_params
    params.require(:comment).permit(:post_id, :text, :comment_id, :file)
  end
end
