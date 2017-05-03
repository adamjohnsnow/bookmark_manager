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
    erb(:links)
  end

  get '/new' do
    erb(:new)
  end

  post '/save_link' do
    link = Link.create(url: params[:url], title: params[:title])
    tags  = Tag.split_tags(params[:tag])
    tags.each { |tag| link.tags << tag }
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    @links = Link.all(Link.tags.name => params[:name])
    erb(:links)
  end
end
  #
