class RelationsController < ApplicationController
  layout "relations/friends", only: [:friends]
  def index
  end

  def friends
  end

  def requests
  end

  def create
    @relation = current_user.senders.new(relation_params)
    if @relation.save
      flash[:success] = "gửi yêu cầu thành công"
    else
      flash[:error] = @relation.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    if @relation.update(relation_params)
      flash[:success] = "kết bạn thành công"
    else
      flash[:error] = @relation.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @relation.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def set_relation
    @relation = current_user.relations.find_by(id: params[:id])
    if @relation.nil?
      flash[:error] = 'bạn không có quyền thao tác'
      redirect_back(fallback_location: root_path)
    end
  end

  def relation_params
    params.require(:relation).permit(:receiver_id, :relation_type)
  end
end
