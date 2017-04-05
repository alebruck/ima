App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    $('#messages').removeClass('hidden')
    return $('#messages').append(this.processData(data));
  },

  processData: function(data) {
    var content = data.chat
    var conection = data.conection

    if(conection) {
      return this.newConectionStatus(conection)
    } else if(content) {
      return this.renderMessage(content);
    } else {
      return ''
    }
  },

  renderMessage: function(content) {
    return '<p>' + content.user + '(' + content.language + '): ' + content.message + '</p>'
  },

  newConectionStatus: function(conection) {
    var user = conection.user
    if(conection.conected) {
      status = 'conected'
    } else if(conection.disconected) {
      status = 'disconected'
    }
    return  user + ' ' + status + '!<br>'
  }
});
