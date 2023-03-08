class MemberRelationsController < ApplicationController
  before_action :check_admin
  before_action :set_relation, only: [:update, :destroy]
  def create
    @relation = current_user.member_relations.new relation_params
    if @relation.save
      flash[:success] = "gửi yêu cầu thành công"
    else
      flash[:error] = @relation.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    if @relation.update(relation_params)
      flash[:success] = "thao tác thành công"
    else
      flash[:error] = @relation.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @relation.destroy
      flash[:success] = "hủy quan hệ thành công"
    else
      flash[:error] = @relation.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def check_admin
    @is_admin = current_user.relation_group(params[:relation][:group_id])&.admin?
  end

  def set_relation
    @relation =
      if @is_admin
        current_user.relation_group(params[:relation][:group_id]).group.member_relations.find_by(id: params[:id])
      else
        current_user.member_relations.find_by(id: params[:id])
      end

    if @relation.nil?
      flash[:error] = 'bạn không có quyền thao tác'
      redirect_back(fallback_location: root_path)
    end
  end

  def relation_params
    params.require(:relation).permit(:group_id, :relation_type)
  end
end
