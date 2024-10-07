# app.rb
require 'sinatra'
require 'json'
require_relative 'my_user_model'

enable :sessions
set :views, './views'

user_model = User.new

before do
  content_type :json
end

# GET /users
get '/users' do
  users = user_model.all.map { |user| user.reject { |k| k == :password } }
  users.to_json
end

# POST /users
post '/users' do
  user_info = {
    firstname: params[:firstname],
    lastname: params[:lastname],
    age: params[:age],
    password: params[:password],
    email: params[:email]
  }
  user_id = user_model.create(user_info)
  user = user_model.find(user_id)
  user.reject { |k| k == :password }.to_json
end

# POST /sign_in
post '/sign_in' do
  email = params[:email]
  password = params[:password]
  user = user_model.all.find { |u| u[:email] == email && u[:password] == password }
  if user
    session[:user_id] = user[:id]
    user.reject { |k| k == :password }.to_json
  else
    status 401
    { error: "Invalid credentials" }.to_json
  end
end

# PUT /users
put '/users' do
  halt 401, { error: "Not logged in" }.to_json unless session[:user_id]
  new_password = params[:password]
  user = user_model.update(session[:user_id], :password, new_password)
  user.reject { |k| k == :password }.to_json
end

# DELETE /sign_out
delete '/sign_out' do
  session.clear
  status 204
end

# DELETE /users
delete '/users' do
  halt 401, { error: "Not logged in" }.to_json unless session[:user_id]
  user_model.destroy(session[:user_id])
  session.clear
  status 204
end

# GET /
get '/' do
  content_type :html
  erb :index
end

# Configure Sinatra to bind to the correct address and port
set :port, 8080
set :bind, '0.0.0.0'

# require 'sinatra'
# require 'json'
# require_relative 'my_user_model'

# enable :sessions
# set :views, './views'

# user_model = User.new

# before do
#   content_type :json
# end

# # GET /users
# get '/users' do
#   users = user_model.all.map { |user| user.reject { |k| k == :password } }
#   users.to_json
# end

# # POST /users
# post '/users' do
#   user_info = {
#     firstname: params[:firstname],
#     lastname: params[:lastname],
#     age: params[:age],
#     password: params[:password],
#     email: params[:email]
#   }
#   user_id = user_model.create(user_info)
#   user = user_model.find(user_id)
#   user.reject { |k| k == :password }.to_json
# end

# # POST /sign_in
# post '/sign_in' do
#   email = params[:email]
#   password = params[:password]
#   user = user_model.all.find { |u| u[:email] == email && u[:password] == password }
#   if user
#     session[:user_id] = user[:id]
#     user.reject { |k| k == :password }.to_json
#   else
#     status 401
#     { error: "Invalid credentials" }.to_json
#   end
# end

# # PUT /users
# put '/users' do
#   halt 401, { error: "Not logged in" }.to_json unless session[:user_id]
#   new_password = params[:password]
#   user = user_model.update(session[:user_id], :password, new_password)
#   user.reject { |k| k == :password }.to_json
# end

# # DELETE /sign_out
# delete '/sign_out' do
#   session.clear
#   status 204
# end

# # DELETE /users
# delete '/users' do
#   halt 401, { error: "Not logged in" }.to_json unless session[:user_id]
#   user_model.destroy(session[:user_id])
#   session.clear
#   status 204
# end

# # GET /
# get '/' do
#   content_type :html
#   erb :index
# end
