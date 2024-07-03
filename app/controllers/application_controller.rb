class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:danger] = I18n.t('flash_messages.cancancan.access_denied')
    redirect_back fallback_location: root_path
  end

end
