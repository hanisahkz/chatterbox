class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user! 
    #this helper has to come after protect_from_forgery to prevent cant verify csrf token error
    #authenticate_user! is some kind of helper
end
