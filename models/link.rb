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
  @database = "postgres://pnpbtwdieojoss:25055d049afe74def87b524d8cfd8ee3a0dda25d35ee8ae10f7808e9b1538498@ec2-54-83-25-217.compute-1.amazonaws.com:5432/dboj9g06brrgh2"
end

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
