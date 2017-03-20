class HomeController < ApplicationController

  def index
    session[:conversations] ||= [] #if session conversation is empty, then assign it with []
 
    @users = User.all.where.not(id: current_user) #users that are not us (the current user)
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations]) #it's interesting how author decides to include receipient but not sender
  end

end
