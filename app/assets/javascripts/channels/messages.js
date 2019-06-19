function createMessageChannel() {
    App.messages = App.cable.subscriptions.create({
          channel: 'MessagesChannel', chat_id: parseInt($("#message_chat_id").val())
          },
          {
          received: function(data) {
            $("#messages").removeClass('hidden')
            return $('#messages').append(this.renderMessage(data));
          },
          renderMessage: function(data) {
            return "<div class='messages'><img src='https://i.pinimg.com/originals/fd/0c/55/fd0c559856ca991e9e28937dc802f0b0.png' class='circle' /> <span class='message-content'><b>" + data.message + "</b></span></div>";
        },
      });
  
  return App.messages;
  }
