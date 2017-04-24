class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "conversations-#{current_user.id}" #to create a unique channel for each user based on their id, also ensures correct users are notified
  end

  def unsubscribed
    stop_all_streams #remove all connected connections
  end

  def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end
 
    Message.create(message_params)
    
    # ActionCable.server.broadcast(
    #   "conversations-#{current_user.id}",
    #   message: message_params
    # )
  end
end

