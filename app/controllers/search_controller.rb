class SearchController < ApplicationController
  before_action :check_question_params, only: %i[friend recommend_user home_post recommend_post joined_group recommend_group,]
  before_action :set_per_page, :friend, :recommend_user, :home_post, :recommend_post, :joined_group, :recommend_group, only: [:index]

  def index
  end

  def friend
    @friends = current_user.friends.includes(:profile).ransack(profile_name_matches: "%#{params[:question]}%").result.page(params[:page]).per(@per_page || 20)
  end

  def recommend_user
    @recommend_users = current_user.recommend_users.includes(:profile).ransack(profile_name_matches: "%#{params[:question]}%").result.page(params[:page]).per(@per_page || 20)
  end

  def home_post
    @home_posts = current_user.home_posts.includes(:user, :group).ransack(
      m: "or",
      user_profile_name_matches: "%#{params[:question]}%",
      group_name_matches: "%#{params[:question]}%",
      text_matches: "%#{params[:question]}%",
    ).result.page(params[:page]).per(@per_page || 20)
  end

  def recommend_post
    @recommend_posts = current_user.recommend_posts.includes(:user, :group).ransack(
      m: "or",
      user_profile_name_matches: "%#{params[:question]}%",
      group_name_matches: "%#{params[:question]}%",
      text_matches: "%#{params[:question]}%",
    ).result.page(params[:page]).per(@per_page || 20)
  end

  def joined_group
    @joined_groups = current_user.joined_groups.ransack(name_matches: "%#{params[:question]}%").result.page(params[:page]).per(@per_page || 20)
  end

  def recommend_group
    @recommend_groups = current_user.recommend_groups.ransack(name_matches: "%#{params[:question]}%").result.page(params[:page]).per(@per_page || 20)
  end

  private

  def set_per_page
    @per_page = 2
  end

  def check_question_params
    if params[:question].nil?
      return redirect_to not_permission_path
    end
  end
end
