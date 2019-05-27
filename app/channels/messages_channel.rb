class MessagesChannel < ApplicationCable::Channel
    def subscribed
      stream_from "messages_#{params[:chat_id]}"
    end
  end