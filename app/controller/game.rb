require_relative 'server_game'

pusher = Pusher::Client.new app_id: '130208', key: '80f3b1aa27d8fa8bf3de', secret: 'dcd4871b115aa9967972'


get '/game/:game_id/play' do
  @id = create_game(params[:game_id])
  erb :'play/index'
end

get '/board/:active_game_id/player1' do
  @id = params[:active_game_id]
  erb :'play/board1'
end

get '/board/:active_game_id/player2' do
  @id = params[:active_game_id]
  erb :'play/board2'
end

  def player_health(player_id)
    Player.find(player_id).player_health
  end

  def deck_size(player_id)
    Player.find(player_id).active_cards.where("status = 'deck'").count
  end

  def draw(player_id)
    card = ActiveCard.where("player_id = ? AND status = 'deck'", player_id).sample
    card.status = "hand"
    card.save
  end

  def show_hand(player_id)
    hand = []
    cards = ActiveCard.where("player_id = ? AND status = 'hand'", player_id)
    cards.each do |card|
      card_data = []
      card_data << card.id
      card_data << card.card_id
      hand << card_data
    end
    hand
  end

  def show_board(player_id)
    board = []
    cards = ActiveCard.where("player_id = ? AND status = 'board'", player_id)
    cards.each do |card|
      card_data = []
      card_data << card.id
      card_data << card.card_id
      board << card_data
    end
    board
  end

  def card_health(active_card_id)
    ActiveCard.find(active_card_id).health
  end

  def card_attack(active_card_id)
    ActiveCard.find(active_card_id).attack
  end

  def fight(attacker_id, target_id)
    attacker = ActiveCard.find(attacker_id)
    target = ActiveCard.find(target_id)
    if attacker.status == 'board' && target.status == 'board'
      target.health -= attacker.attack
      attacker.health -= target.attack
      target.save
      attacker.save
    else
      false
    end
  end

  def clear_board(active_game_id)
    players = Player.where("active_game_id = ?", active_game_id)
    players.each do |player|
      cards = ActiveCard.where("player_id = ?", player.id)
      cards.each do |card|
        if card.health <= 0
          card.destroy
        end
      end
    end
  end

  def play(active_card_id)
    card = ActiveCard.where("id = ? AND status = 'hand'", active_card_id)[0]
    card.status = "board"
    card.save
  end

  def next_turn(active_game_id)
    game = ActiveGame.find(active_game_id)
    game.turn += 1
    game.save
  end

  def turn?(active_game_id)
    game = ActiveGame.find(active_game_id)
    if game.turn.even?
      2
    else
      1
    end
  end

  def game_over?(active_game_id)
    game = ActiveGame.find(active_game_id)
    game.players.each do |player|
      if player.player.player_health <= 0
        return true
      end
    end
  end


def create_game(game_id)
  @game = Game.find(game_id)
  @active_game = ActiveGame.create(
    game_id: @game.id,
    turn: 1
  )
  @player1 = Player.create(
    active_game_id: @active_game.id,
    player_health: @game.health
  )
  @player2 = Player.create(
    active_game_id: @active_game.id,
    player_health: @game.health
  )
  @active_game.player1_id = @player1.id
  @active_game.player2_id = @player2.id
  @active_game.save

  (0..@game.deck_size).each do |n|
    card = @game.cards.all.sample
    ActiveCard.create(
      player_id: @player1.id,
      card_id: card.id,
      attack: card.attack,
      health: card.defense,
      status: 'deck'
    )
  end

  (0..@game.deck_size).each do |n|
    card = @game.cards.all.sample
    ActiveCard.create(
      player_id: @player2.id,
      card_id: card.id,
      attack: card.attack,
      health: card.defense,
      status: 'deck'
    )
  end

  (0..@game.hand_size).each do |n|
    card = ActiveCard.where("player_id = ? AND status = 'deck'", @player1.id).sample
    card.status = "hand"
    card.save
  end

  (0..@game.hand_size).each do |n|
    card = ActiveCard.where("player_id = ? AND status = 'deck'", @player2.id).sample
    card.status = "hand"
    card.save
  end

  @active_game.id
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