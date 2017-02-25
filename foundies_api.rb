require "rubygems"
require "sinatra/base"
require "json"

class FoundiesApi < Sinatra::Base

  before do
    if request.request_method == 'POST'
      body_params = request.body.read
      params.merge! JSON.parse(body_params)
    end
  end

  get '/' do
    "Hello everyone"
  end

  get '/users' do
    { users: User.all.map { |user| user.as_json } }.to_json
  end

  get '/user/:id' do
    { user: User.where(id: params[:id].to_i).first.as_json }.to_json
  end

  post '/users' do
    user = User.where(user_params).create
    { user: user.as_json }.to_json
  end

  put '/user/:id' do
    "You just updated user id #{params[:id]}"
  end

  delete '/user/:id' do
    "You just deleted user id #{params[:id]}"
  end

  private

  def user_params
    {
      username: params['user']['username'],
      first_name: params['user']['first_name'],
      last_name: params['user']['last_name']
    }
  end
end
