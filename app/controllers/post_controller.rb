class HomeController < ApplicationController
  before_action :authenticate_user!
  def store
    Post.create(params)
  end
end
