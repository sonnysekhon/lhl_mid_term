# Homepage (Root path)
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
  # erb :login
end

post '/login' do
  # binding.pry
  # if User.find_by(name: params[:username], password: params[:password])  
  #   @current_user_id = User.find_by(name: params[:username], password: params[:password]).id
  #   session[:user] = params[:username] 
  #   session[:user_id] = @current_user_id
  #   redirect to('/view')
  # else
  #   erb :login
  # end 
end