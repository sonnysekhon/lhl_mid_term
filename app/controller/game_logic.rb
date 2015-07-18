require_relative 'server_game'

@game = ServerGame.new

@game.join_game(11111)
@game.join_game(22222)

@game.start_game

until @game.game_over? == true

  puts "THE BOARD"
  puts "player one health: #{@game.find_health(11111)}"
  puts "player two health: #{@game.find_health(22222)}"
  puts @game.board
  puts "\n"

#### DRAW PHASE #####
  puts "Your Current hand"
  puts @game.current_player.hand.inspect

  puts "Lets Draw a Card"
  @game.draw

  puts "Here's your new hand"
  puts @game.current_player.hand.inspect

#### PLAY PHASE #####

  puts "Which card would you like to play? (enter index or 'n' to pass)"
  response = gets.chomp
  if response == 'n'
    false
  else
    @game.play(response.to_i)
  end

  puts "THE BOARD"
  puts "player one health: #{@game.find_health(11111)}"
  puts "player two health: #{@game.find_health(22222)}"
  puts @game.board
  puts "\n"

#### ATTACK PHASE ####

  puts "time to attack\n"

  puts "select a unit"
  unit = gets.chomp.to_i

  puts "select a target"
  enemy = gets.chomp

  if enemy == "opponent"
    enemy = @game.opponent
    puts "you're attacking #{enemy.name}"
    @game.attack_opponent(unit, enemy)
  else
    enemy = enemy.to_i
    puts "you're attacking #{@game.board[@game.opponent.id][enemy].name}"
    @game.attack_unit(unit, enemy)
  end

### CLEAN UP PHASE #####

  @game.clear_board
  @game.next_player

  puts "THE BOARD"
  puts "player one health: #{@game.find_health(11111)}"
  puts "player two health: #{@game.find_health(22222)}"
  puts @game.board
  puts "\n"

end

puts "GAME OVER!"

