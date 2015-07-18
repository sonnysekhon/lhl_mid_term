# Homepage (Root path)
# configure do #dont need this
#   enable :sessions
# end

require_relative 'controller/game'

helpers do
  def current_user
    if session[:id]
      if @current_user.nil?
        @current_user = User.find(session[:id])
      end
    end
    @current_user
  end
end

get '/' do
  erb :index
end

get "/signup" do
  erb :'signup/index'
end

post '/signup' do
  #binding.pry
  user = User.new(
    name: params[:name],
    email: params[:email],
    password:  params[:password],
    avatar: params[:avatar]
  )
  user.save
  session[:id] = user.id
  redirect '/dash'
end

get '/login' do
  erb :'login/index'
end

post '/login' do
  user = User.find_by(email: params[:email], password: params[:password])
  if user
    session[:email] = user.email
    session[:id] = user.id
    # binding.pry
    redirect to('/dash')
  else
    erb :index
  end
end

get '/dash' do
  @games = current_user.games
  erb :dash
end

get '/game/create' do
  erb :'game/create'
end

post '/game/create' do
  @a_game = Game.new(
    title: params[:title],
    health: params[:health],
    deck_size: params[:deck_size],
    hand_size: params[:hand_size]

  )
  @a_game.user_id = current_user.id
  #binding.pry
  @a_game.save
  redirect '/dash'
end

get '/game/:id' do
  @a_game = Game.find(params[:id])
  @cards = @a_game.cards
  erb :'game/info'
end

get '/game/:id/edit' do
  @a_game = Game.find(params[:id])
  #binding.pry
  erb :'game/edit'
end

put '/game/:id/update' do
  @a_game = Game.find(params[:id])
  @a_game.update(title: params[:title], health: params[:health], deck_size: params[:deck_size], hand_size: params[:hand_size])

  if @a_game.save
  #binding.pry

    redirect "/game/#{@a_game.id}"
  else
    erb :'game/edit'
  end
end

get '/game/:id/cards/new' do
  @a_game = Game.find(params[:id])
  @a_card = Card.new
  erb :'game/card/create'
end

post '/game/:id/cards/new' do
  @a_game = Game.find(params[:id])
  @a_card = Card.new(
  name: params[:name],
  picture: params[:picture],
  attack: params[:attack],
  defense: params[:defense]
  )
  @a_card.game_id = @a_game.id
  @a_card.save
  redirect "/game/#{@a_game.id}"
end



get '/game/:game_id/cards/:id/edit' do
  @a_game = Game.find_by( id: params[:game_id] )
  @cards = @a_game.cards
  @a_card = @cards.find(params[:id])
  erb :'game/card/edit'

end

put '/game/:game_id/cards/:id/update' do
  @a_game = Game.find_by( id: params[:game_id] )
  @cards = @a_game.cards
  @a_card = @cards.find(params[:id])
  @a_card.update(name: params[:name], picture: params[:picture], attack: params[:attack], defense: params[:defense])
  if @a_card.save
    redirect "/game/#{@a_game.id}"
  else
    erb :'game/card/edit'
  end
end


get '/logout' do
  session.clear
  #binding.pry
  redirect to('/login')
end

get "/upload_image" do
  erb :'img/form'
end

get "/test" do
  @users = User.all
  erb :test
end

post "/test" do
  clicked_id = params[:test1].to_i
end

post "/test2" do
  active_card_id = params[:card].to_i
  #binding.pry
  play(active_card_id)
  redirect to('/board/1/player1')
end

post '/save_image' do

 @filename = params[:file][:filename]
 file = params[:file][:tempfile]

 File.open("./public/#{@filename}", 'wb') do |f|
   f.write(file.read)
 end

 erb :'img/show_image'

end
