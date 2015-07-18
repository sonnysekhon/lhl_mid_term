require 'byebug'
require_relative 'server_player'
require_relative 'server_card'

class ServerGame
  MAX_PLAYERS = 2

  attr_reader :players, :pool, :deck_size, :hand_size, :player_health
  attr_accessor :board

  def initialize (pool, hand_size, deck_size, player_health)
    @players = []
    @board = {}
    @pool = pool
    @hand_size = hand_size
    @deck_size = deck_size
    @player_health = player_health
  end

  def join_game(player_id, health = player_health)
    return false unless @players.size < MAX_PLAYERS
    player = ServerPlayer.new(player_id, health)
    @players << player
    true
  end

########## SETUP GAME METHODS ###########

  def start_game
    setup_board
    create_decks
    draw_hands
  end

  def setup_board
    players.each do |player|
      board[player.id] = []
    end
  end

  def create_decks
    @players.each do |player|
      (0..@db_deck_size).each do |n|
        card = ServerCard.new(@db_pool.sample)
        player.deck << card
      end
    end
  end

  def draw_hands
    @players.each do |player|
      (0..@db_hand_size).each do |n|
        card = player.deck.shift
        player.hand << card
      end
    end
  end

####### GAME TURN METHODS ##########

  def current_player
    players[0]
  end

  def opponent
    players[1]
  end

  def find_health(player_id)
    player = players.find { |player| player.id == player_id }
    player.health
  end

  def draw
    current_player.pickup
  end

  def play(card_position)
    card = current_player.play_card(card_position)
    board[current_player.id] << card
    board
  end

  def attack_unit(attacker_index, enemy_index)
    attacking_unit = board[current_player.id][attacker_index]
    enemy_unit = board[opponent.id][enemy_index]
    attacking_unit.damage(enemy_unit)
  end

  def attack_opponent(attacker_index, opponent)
    attacking_unit = board[current_player.id][attacker_index]
    attacking_unit.damage(opponent)
  end

  def clear_board
    board.each do |player_id, cards|
      cards.each_with_index do |card, index|
        board[player_id].delete_at(index) unless card.alive?
      end
    end
  end

  def next_player
    @players.insert(-1, @players.delete_at(0))
  end

###### GAME END STATES ##########

  def game_over?
    players.each do |player|
      return true unless player.alive?
    end
    false
  end

end

# # DRIVE CODE

# puts @game = ServerGame.new

# puts @game.join_game(1)
# puts @game.join_game(2)
# puts @game.join_game(3)

# puts "\ncreate_decks"
# puts @game.create_decks

# puts "\ndraw_hands"
# puts @game.draw_hands

# puts "\nplayers"
# puts @game.players

# puts "\nnext_player"
# @game.next_player
# puts @game.current_player.inspect

# puts "\nplayers"
# puts @game.players.inspect

# puts "\nsetup_board"
# puts @game.setup_board.inspect
# puts @game.board.inspect

# puts "\nplay to board"
# puts @game.play(1).inspect

# puts "\nnext_player"
# puts @game.next_player.inspect

# puts "play to board"
# puts @game.play(1).inspect

# puts "\n attack"
# puts @game.attack_unit(0, 0).inspect

# puts "SHOW BOARD BEFORE DELETE"
# puts @game.board.inspect

# puts "clear_board"
# puts @game.clear_board.inspect

# puts "SHOW BOARD AFTER DELETE"
# puts @game.board.inspect

# puts "Opponent Health"
# puts @game.opponent.health

# puts "attack opponent"
# puts @game.attack_opponent(0, @game.opponent)

# puts "Opponent Health"
# puts @game.opponent.health

# puts "Gameover?"
# puts @game.game_over?

# puts "attack opponent to trigger game over"
# puts @game.attack_opponent(0, @game.opponent)

# puts "Gameover?"
# puts @game.game_over?






