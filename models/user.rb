require 'bcrypt'
require 'data_mapper'
require_relative 'link'

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :first_name, String
  property :surname, String
  property :email, String
  property :password, String

  has n, :links
end
