class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :check_comment_ability, only: %i[create update]
  before_action :set_comment, only: %i[update destroy]

  def index
    post = Post.find_by(id: params[:post_id])
    comment = Comment.find_by(id: params[:comment_id])
    content = Content.find_by(id: params[:content_id])
    @new_comment = current_user.comments.new
    if comment
      @comments = comment.comments.page(params[:page])
      @tag_id = "rep_comment_#{comment.id}"
    elsif content
      @comments = content.comments.page(params[:page])
      @tag_id = "comment_content_#{content.id}"
    else
      @comments = post.comments.where.not(id: params[:_comment_id]).low.page(params[:page])
      @tag_id = "comment_post_#{post.id}"
    end
  end

  def create
    @comment = current_user.comments.new comment_params
    if @comment.save
      @new_comment = current_user.comments.new
      if @pre_comment
        @tag_id = "#new_rep_comment_#{@pre_comment.id}"
      elsif @content
        @tag_id = "#new_comment_content_#{@content.id}"
      else
        @tag_id = "#new_comment_post_#{@post.id}"
      end
      render :create
    else
      flash[:error] = @comment.errors.full_messages
      render_post_error(comment_params[:post_id])
    end
  end

  def update
    if @comment.update comment_params
      @new_comment = current_user.comments.new
      render :update
    else
      flash[:error] = @comment.errors.full_messages
      render_post_error(comment_params[:post_id])
    end
  end

  def destroy
    if @comment.destroy
      render :destroy
    else
      flash[:error] = @comment.errors.full_messages
      render_post_error(@comment.post_id)
    end
  end

  private

  def check_comment_ability
    @post = Post.find_by(id: comment_params[:post_id])
    @content = @post.contents.find_by(id: comment_params[:content_id])
    @pre_comment = @post.comments.find_by(id: comment_params[:comment_id])
    block = current_user.be_blocked(comment_params[:post_id])
    if !@post.comment_flag
      flash[:error] = t "comments.save.comment_flag_off"
      render_post_error(comment_params[:post_id])
    elsif block
      flash[:error] = t "comments.save.be_block"
      render_post_error(comment_params[:post_id])
    elsif @pre_comment&.high?
      flash[:error] = t "comments.save.reached_limit"
      render_post_error(comment_params[:post_id])
    end
  end

  def set_comment
    @comment = current_user.comments.find_by(id: params[:id])
    if @comment.nil?
      flash[:error] = t "error.not_permission"
      render_post_error(comment_params[:post_id])
    end
  end

  def render_post_error(post_id)
    render template: "posts/error",
           locals: { post_id: post_id }
  end

  def comment_params
    params.require(:comment).permit(:post_id, :text, :comment_id, :content_id, :file)
  end
end
