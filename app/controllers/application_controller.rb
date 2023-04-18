class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || current_user&.locale || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
