class MemberRelationsController < ApplicationController
  def create
    @relation = current_user.member_relations.new relation_params
    unless @relation.save
      flash[:error] = @relation.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    unless current_user.is_permissioned params[:id]
      flash[:error] = 'bạn không có quyền chỉnh sửa'
    else
      @relation =  MemberRelation.find params[:id]
      unless @relation.update(relation_params)
        flash[:error] = @relation.errors.messages.first
      end
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    if current_user.member_relations.exists?(id: params[:id]) || current_user.is_permissioned(params[:id])
      @relation = MemberRelation.find params[:id]
      @relation.destroy
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = 'bạn không có quyền xóa'
    end
  end

  def relation_params
    params.require(:relation).permit(:group_id, :relation_type)
  end
end
