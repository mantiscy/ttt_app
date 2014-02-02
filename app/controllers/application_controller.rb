class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    alert_message = case 
                    when current_user
                      redirect_to ttts_path, notice: "You don't have access to this page"
                    else
                      "You need to login as a registered user to access this page"
                      redirect_to login_path, alert: alert_message
                    end
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
