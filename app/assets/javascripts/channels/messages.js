App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    var objDiv = document.getElementById('messages');
    $('#messages').append(this.processData(data));
    objDiv.scrollTop = objDiv.scrollHeight;
    return
  },

  processData: function(data) {
    var content = data.chat
    var conection = data.conection

    if(conection) {
      return this.newConectionStatus(conection)
    } else if(content) {
      return this.renderMessage(content);
    } else {
      return '';
    }
  },

  renderMessage: function(content) {
    return '<div class="row message-row"><div class="col col-lg-9">' + this.renderUserImage(content.language) + '<span class="user-message"><b>' + content.user + '</b>: ' + this.renderMessageStyle(content.message) + '</span></div><div class="col col-lg-3">' + this.renderMessageTime() + '</div></div>';
  },

  renderMessageStyle: function(message) {
    return urlify(message);
  },

  renderMessageTime: function() {
    return '<span class="pull-right">' + new Date().toLocaleString() + '</span>'
  },

  renderUserImage: function(language) {
    var asset = language.replace(/\s+/g, '-').toLowerCase();
    return '<img src="/assets/'+ asset +'">'
  },

  newConectionStatus: function(conection) {
    var user = conection.user
    if(conection.conected) {
      status = 'conected'
    } else if(conection.disconected) {
      status = 'disconected'
    }
    return  '<i><small>' + user + ' ' + status + '!</small></i><br>';
  }
});

function urlify(text) {
  var urlRegex =/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
  return text.replace(urlRegex, function(url) {
      return '<a href="' + url + '" target="_blank">' + url + '</a>';
  })
}
