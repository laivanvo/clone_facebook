class ProfilesController < ApplicationController
  def update
    @profile = current_user.profile.find_by(id: params[:id])
    if @profile.nil?
      flash[:error] = t ".not_permission"
      return redirect_back(fallback_location: root_path)
    end
    if @profile.update
      flash[:success] = t "update.success"
    else
      flash[:error] = @post.errors.full_messages
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def profile_params
    params.require(:profile).permit(:name, :address, :birthday, :avatar)
  end
end
