require_relative 'server_game'

# pusher = Pusher::Client.new app_id: '130208', key: '80f3b1aa27d8fa8bf3de', secret: 'dcd4871b115aa9967972'

get '/play' do
  # pool = []
  # card_pool = current_user.games.find(params[:id]).cards.each do |card|
  #               result = card.id
  #               pool << result
  #             end
  # hand_size = current_user.games.find(params[:id]).hand_size
  # player_health = current_user.games.find(params[:id]).health
  # deck_size = current_user.games.find(params[:id]).deck_size
  # @game = ServerGame.new(pool, hand_size, deck_size, player_health)
  # @game.join_game(current_user.id)
  erb :'play/index'
end

get '/join_game' do
  game.join_game(current_user.id)
  erb :'play/index'
end

get '/notification' do
    pusher.trigger('notifications', 'new_notification', {
        message: 'hello world'
    })
    "Notification triggered!"
end

post '/notification' do
  message = params[:message]
  puts "OMG WTF #{message}"


  pusher.trigger('notifications', 'new_notification', {
    message: message
  })
end