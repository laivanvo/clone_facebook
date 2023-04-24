class PostsController < ApplicationController
  before_action :check_admin, only: [:update, :destroy]
  before_action :set_post, only: [:update, :destroy]
  before_action :set_post_show, only: [:show, :edit, :contents]
  before_action :set_new_comment
  layout "posts/show", only: [:show]

  def index
    group = Group.find_by(id: params[:group_id])
    if group.nil?
      @posts = current_user.home_posts.includes(:comments, :reactions).page(params[:page])
    else
      @posts = group.posts.passed.includes(:comments, :reactions).page(params[:page])
    end
  end

  def new
    @post = current_user.posts.new
    @local = true
    render :form
  end

  def edit
    @local = false
    render :form
  end

  def show
    @current_comment = Comment.find_by(id: params[:current_comment_id])
  end

  def contents
    @content = @post.contents.find_by(id: params[:content_id])
    @current_comment = Comment.find_by(id: params[:current_comment_id])
    render :content
  end

  def create
    status = @is_admin ? :passed : :pending
    @post = current_user.posts.new post_params.merge(status: status)
    if @post.save
      flash[:success] = t "create.success"
    else
      flash[:error] = @post.errors.full_messages
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    status = @is_admin ? :passed : :pending
    if @post.update(post_params.merge(status: status))
      flash[:success] = t "update.success"
      render :update
    else
      flash[:error] = @post.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t "destroy.success"
    else
      flash[:error] = @post.errors.full_messages
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
      flash[:error] = t ".not_permission"
      redirect_back(fallback_location: root_path)
    end
  end

  def set_post_show
    @post = Post.find_by(id: params[:id])
    if @post.nil? || !@post.readable_users.include?(current_user.id)
      return redirect_to not_permission_path
    end
  end

  def set_new_comment
    @new_comment = current_user.comments.new
  end

  def post_params
    params.require(:post).permit(:text, :mode, :group_id, :comment_flag, contents_attributes: %i[id caption file _destroy])
  end
end
