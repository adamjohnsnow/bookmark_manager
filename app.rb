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
    session[:user_id] = nil
    erb(:index)
  end

  get '/links' do
    @links = Link.all(Link.user_id => session[:user_id])
    @name = session[:user_name]
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
    session[:message] = nil
    @user = User.login(params)
    if @user == nil
      session[:message] = 'Wrong password'
      redirect '/'
    else
      session[:user_id] = @user.id
      session[:user_name] = @user.first_name
      redirect '/links'
    end
  end

  get '/sign_up' do
    erb(:sign_up)
  end

  post '/sign_up' do
    bad_passwords if params[:password] != params[:verify_password]
    @user = User.create(params)
    session[:user_id] = @user.id
    session[:user_name] = @user.first_name
    redirect '/links'
  end

  get '/tags/:name' do
    @links = Link.all(Link.tags.name => params[:name])
    erb(:links)
  end

  private

  def bad_passwords
    session[:message] = "Mismatched passwords, please try again"
    redirect '/sign_up'
  end

end
