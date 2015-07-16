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
    session[:id] = User.find_by(email: params[:email], password: params[:password]).id 
    #binding.pry
    redirect to('/')
  else
    erb :index
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
 
post '/save_image' do
  
  @filename = params[:file][:filename]
  file = params[:file][:tempfile]
 
  File.open("./public/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  
  erb :'img/show_image'
end