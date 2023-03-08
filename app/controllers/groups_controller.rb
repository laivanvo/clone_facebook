class GroupsController < ApplicationController
  layout :show_layout, only: [:show, :members]
  def index
    @group = Group.new
    @recommend_groups = current_user.recommend_groups.paginate(page: params[:page], per_page: 2)
    @friend_groups = current_user.recommend_groups.paginate(page: params[:page], per_page: 2)
  end

  def show
    @group = Group.find params[:id]
    @post = Post.new
    @passed_posts = @group.posts.passed
    @inprocess_posts = @group.posts.inprocess
    @relation = current_user.relation_group(params[:id])
  end

  def members
    @group = Group.find params[:id]
    @requests = @group.member_relations.requested
  end

  def create
    @group = current_user.groups.new group_params
    unless @group.save
      flash[:error] = @group.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def group_params
    params.require(:group).permit(:name, :avatar)
  end

  def show_layout
    relation = current_user.relation_group(params[:id].to_i)
    if relation && relation.admin?
      "groups/admin/show"
    else
      "groups/member/show"
    end
  end
end
