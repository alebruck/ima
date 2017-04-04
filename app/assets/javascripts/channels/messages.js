App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    $('#messages').removeClass('hidden')
    return $('#messages').append(this.processData(data));
  },

  processData: function(data) {
    return '<p>' + data.user + '(' + data.language + '): ' + this.renderMessage(data.message) + '</p>';
  },

  renderMessage: function(message) {
    return message
  }
});
