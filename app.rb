require 'sinatra/base'
require 'pry'
require_relative './models/link'
require_relative './models/tag'
require_relative 'data_mapper_setup'

ENV['RACK_ENV'] ||= 'development'

class BookmarkManager < Sinatra::Base
  enable :sessions
  set :session_secret ,''

  get '/' do
    erb(:index)
  end

  get '/links' do
    @links = Link.all(Link.user_id => session[:user_id])
    erb(:links)
  end

  get '/new' do
    erb(:new)
  end

  post '/save_link' do
    link = Link.create(url: params[:url], title: params[:title])
    tags  = Tag.split_tags(params[:tag])
    tags.each { |tag| link.tags << tag }
    link.user_id = session[:user_id]
    link.save
    redirect '/links'
  end

  post '/sign_in' do
    redirect '/links'

  end

  get '/sign_up' do
    erb(:sign_up)
  end

  post '/sign_up' do
    user = User.create(
    email: params[:email],
    first_name: params[:first_name],
    surname: params[:surname],
    password: params[:password]
    )
    session[:user_id] = user.id
    redirect '/links'
  end

  get '/tags/:name' do
    @links = Link.all(Link.tags.name => params[:name])
    erb(:links)
  end
end
