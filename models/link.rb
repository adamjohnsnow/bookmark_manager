require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'tag'
require_relative 'user'

class Link
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :url, URI

  belongs_to :user, required: false
  has n, :tags, through: Resource
end
