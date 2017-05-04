require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'models/tag'
require_relative 'models/link'

if ENV['RACK_ENV'] == 'test'
  @database = "postgres://localhost/bookmark_manager_test"
else
  @database = "postgres://localhost/bookmark_manager_development"
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || @database)
DataMapper.finalize
DataMapper.upgrade!
