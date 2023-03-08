class RelationsController < ApplicationController
  def index
    @friends = current_user.friends
  end

  def create
    @relation = current_user.senders.new(relation_params)
    unless @relation.save
      flash[:error] = @relation.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @relation = current_user.relations.find params[:id]
    unless @relation.update(relation_params)
      flash[:error] = @relation.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @relation = current_user.relations.find params[:id]
    @relation.destroy
    redirect_back(fallback_location: root_path)
  end

  def relation_params
    params.require(:relation).permit(:receiver_id, :relation_type)
  end
end
