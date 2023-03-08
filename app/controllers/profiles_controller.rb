class ProfilesController < ApplicationController
  def update
    @profile = current_user.profile.find_by(id: params[:id])
    if @profile.nil?
      flash[:error] = 'bạn không có quyền thao tác'
      return redirect_back(fallback_location: root_path)
    end
    if @profile.update
      flash[:success] = 'cập nhật profile thành công'
    else
      flash[:error] = @post.errors.messages.first
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def profile_params
    params.require(:profile).permit(:name, :address, :birthday, :avatar)
  end
end
