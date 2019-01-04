class ApplicationController < ActionController::Base

  def current_user
    User.last
  end
  
  helper_method :current_user

end
