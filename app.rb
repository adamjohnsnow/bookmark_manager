require 'sinatra/base'
require 'pry'
require_relative './models/link'
require_relative './models/tag'
require_relative 'data_mapper_setup'

ENV['RACK_ENV'] ||= 'development'

class BookmarkManager < Sinatra::Base
  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    @tags = Tag.all
    erb(:links)
  end

  get '/new' do
    erb(:new)
  end

  post '/save_link' do
    link = Link.new(url: params[:url], title: params[:title])
    tag  = Tag.first_or_create(name: params[:tag])
    link.tags << tag
    link.save
    redirect '/links'
  end
end
