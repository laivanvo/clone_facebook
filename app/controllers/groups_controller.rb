class GroupsController < ApplicationController
  layout :show_layout, only: [:show, :members, :pending_posts]
  before_action :set_group, only: [:show, :members, :pending_posts]
  before_action :check_admin
  before_action :check_permission, only: [:members]

  def index
    @group = Group.new
    @recommend_groups = current_user.recommend_groups
    @friend_groups = current_user.friend_groups
  end

  def show
    @post = Post.new
    @relation = current_user.relation_group(params[:id])
  end

  def members
    @requests = @group.member_relations.requested
  end

  def pending_posts
    @pending_posts = @is_admin ? @group.posts.pending : current_user.posts.pending.where(group_id: @group.id)
  end

  def of_friend
    @friend_groups = current_user.friend_groups
  end

  def create
    @group = current_user.groups.new group_params
    if @group.save
      flash[:success] = "tạo nhóm thành công"
    else
      flash[:error] = @group.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end


  def show_layout
    relation = current_user.relation_group(params[:id])
    if relation && relation.admin?
      "groups/admin/show"
    else
      "groups/member/show"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :avatar)
  end

  def set_group
    @group = Group.find params[:id]
  end

  def check_admin
    @is_admin = current_user.relation_group(params[:id]) && current_user.relation_group(params[:id]).admin?
  end

  def check_permission
    unless @is_admin
      redirect_to not_permission_path
    end
  end
end
