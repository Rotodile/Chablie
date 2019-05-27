class MessagesController < ApplicationController

    def create
        message = Message.new(message_params)
        message.user = current_user
        if message.save
          ActionCable.server.broadcast( "messages_#{message_params[:chat_id]}",
          message: message.content,
          user: message.user.username
          )
        else
          redirect_to chats_path
        end
    end
    
    private
        def message_params
          params.require(:message).permit(:content, :chat_id)
        end
end