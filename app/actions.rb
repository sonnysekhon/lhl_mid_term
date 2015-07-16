# Homepage (Root path)
# configure do #dont need this
#   enable :sessions
# end

helpers do
  def current_user
    if session[:user_id]
      if @current_user.nil?
        @current_user = User.find_by(session[:user_id])
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
  session[:user_id] = user.id
  redirect '/'
end

get '/login' do
  erb :'login/index'
end

# post '/login' do  
#  if User.find_by(email: params[:email], password: params[:password])  
#    session[:email] = params[:email]
#    session[:id] = User.find_by(email: params[:email], password: params[:password]).id 
#    #binding.pry
#    redirect to('/dash')
#  else
#   @message = "login failed"
#    erb :'login/index'
#  end 
# end
post '/login' do  
  # if User.find_by(email: params[:email], password: params[:password])  
  #   session[:email] = params[:email] 
  #   #binding.pry
  #   redirect to('/dash')
  # else
  #   erb :index
  # end 
  user = User.find_by(email: params[:email])

  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/dash'
  else
    @message = "login failed"
    erb :'login/index'
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
  @a_game.save
  redirect '/dash'
end
get '/logout' do
  session.clear
  redirect to('/login')
end

get "/upload_image" do
 erb :form
end

post '/save_image' do
 
 @filename = params[:file][:filename]
 file = params[:file][:tempfile]

 File.open("./public/#{@filename}", 'wb') do |f|
   f.write(file.read)
 end
 
 erb :show_image
end