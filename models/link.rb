require 'data_mapper'
require 'dm-postgres-adapter'

class Link
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :url, URI
end

if ENV['RACK_ENV'] == 'test'
  @database = "postgres://localhost/bookmark_manager_test"
else
  @database = "postgres://localhost/bookmark_manager_development"
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || @database)
DataMapper.finalize
DataMapper.auto_upgrade!
