require 'sinatra/base'
require 'pry'
require_relative './models/link'

ENV['RACK_ENV'] ||= 'development'

class BookmarkManager < Sinatra::Base
  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end

  get '/new' do
    erb(:new)
  end

  post '/save_link' do
    Link.create(url: params[:url], title: params[:title], tag: params[:tag])
    redirect '/links'
  end
end
