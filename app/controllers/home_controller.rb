class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    gon.mode = 'Tùy chỉnh'
  end
end
