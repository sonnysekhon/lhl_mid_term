$(document).ready(function(){

var pusher = new Pusher('80f3b1aa27d8fa8bf3de');

var gameChannel = pusher.subscribe('notifications');

gameChannel.bind('new_notification', function(notification){
    // var message = notification.message;
    // $('div.hm').text(message);
    location.reload();
});

gameChannel.bind('game_over', function(notification){
    window.location.replace("/game_over");
});

var nextPlayer = function(){
  // get the contents of the input
  var id = $('button.finish_turn').val();
  // POST to our server
  $.post('/notification', {active_game_id: id}).success(function(){
      console.log('Next Player Notification Sent!');
  });
};

$('button.finish_turn').on('click', nextPlayer);

});