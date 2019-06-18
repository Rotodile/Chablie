function createMessageChannel() {
    App.messages = App.cable.subscriptions.create({
          channel: 'MessagesChannel', chat_id: parseInt($("#message_chat_id").val())
          },
          {
          received: function(data) {
              debugger
            $("#messages").removeClass('hidden')
            return $('#messages').append(this.renderMessage(data));
          },
          renderMessage: function(data) {
              debugger
      return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
    },
        });
  
  return App.messages;
  }
