require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'tag'

class Link
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :url, URI

  has n, :tags, through: Resource
end
