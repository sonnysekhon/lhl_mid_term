$(document).ready(function(){

  var pusher = new Pusher('80f3b1aa27d8fa8bf3de');

  var nextplayerChannel = pusher.subscribe('notifications');

  nextplayerChannel.bind('new_notification', function(notification){
      // var message = notification.message;
      // $('div.hm').text(message);
      location.reload();
  });

  var nextPlayer = function(){
    // get the contents of the input
    var text = $('input.create-notification').val();
    // POST to our server
    $.post('/notification').success(function(){
        console.log('Next Player Notification Sent!');
    });
  };

  $('button.finish_turn').on('click', nextPlayer);

  });

});