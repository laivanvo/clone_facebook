class PostsController < ApplicationController
  before_action :check_admin, only: [:update, :destroy]
  before_action :set_post, only: [:update, :destroy]

  def index
    group = Group.find_by(id: params[:group_id])
    if group.nil?
      @posts = current_user.home_posts.includes(:comments, :reactions).page(params[:page])
    else
      @posts = group.posts.passed.includes(:comments, :reactions).page(params[:page])
    end
  end

  def create
    status = @is_admin ? :passed : :pending
    @post = current_user.posts.new post_params.merge(status: status)
    if @post.save
      flash[:success] = "tạo bài viết thành công"
    else
      flash[:error] = @post.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    status = @is_admin ? :passed : :pending
    if @post.update(post_params.merge(status: status))
      flash[:success] = "cập nhật bài viết thành công"
    else
      flash[:error] = @post.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @post.destroy
      flash[:success] = "xóa bài viết thành công"
    else
      flash[:error] = @post.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def check_admin
    @is_admin = current_user.relation_group(params[:post][:group_id])&.admin?
  end

  def set_post
    @post = if @is_admin
        current_user.relation_group(params[:post][:group_id]).group.posts.find_by(id: params[:id])
      else
        current_user.posts.find_by(id: params[:id])
      end

    if @post.nil?
      flash[:error] = "bạn không có quyền thao tác"
      redirect_back(fallback_location: root_path)
    end
  end

  def post_params
    params.require(:post).permit(:text, :mode, :content, :group_id, :comment_flag)
  end
end
