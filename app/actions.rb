# Homepage (Root path)
configure do
  enable :sessions
end

get '/' do
  erb :index
end

get "/signup" do
  erb :'signup/index'
end

post '/signup' do
  #binding.pry
  @user = User.new(
    name: params[:name],
    email: params[:email],
    password:  params[:password],
    avatar: params[:avatar]
    
  )
  @user.save
  redirect '/'
end

get '/login' do
  erb :'login/index'
end

post '/login' do  
  if User.find_by(email: params[:email], password: params[:password])  
    session[:email] = params[:email] 
    binding.pry
    redirect to('/')

  else
    erb :index
  end 
end

get '/logout' do
  session.clear
  redirect to('/login')
end