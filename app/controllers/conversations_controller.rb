class ConversationsController < ApplicationController
  def create
    #in a way, the assumption is that, sender == current_user, params[:user_id] == the opposite user
    #this method has been defined in conversation.rb
    @conversation = Conversation.get(current_user.id, params[:user_id])
    
    # this is to make sure that the session for conversation is not empty
    add_to_conversations unless conversated? #if converstaed is false (session id empty), then a_t_c (give id)

    respond_to do |format|
      format.js
    end
  end

  #this action removes session conversation from the chatbox once the window is closed
   def close
    @conversation = Conversation.find(params[:id])
    session[:conversations].delete(@conversation.id)
    respond_to do |format|
      format.js
    end
  end

  private

  def add_to_conversations
    session[:conversations] ||= [] #if session is empty, assign []
    session[:conversations] << @conversation.id #then, insert the con_id into the array
  end

  def conversated?
    session[:conversations].include?(@conversation.id) #the 2 people are considered talking when the session contains conversation id
  end
end