require 'bcrypt'
require 'data_mapper'
require_relative 'link'

class User
  include DataMapper::Resource
  include BCrypt

  property :id, Serial
  property :first_name, String
  property :surname, String
  property :email, String, :unique => true
  property :password_digest, Text

  has n, :links

  def password=(pass)
    self.password_digest = BCrypt::Password.create(pass)
  end

  def self.create(params)
    @user = User.new(first_name: params[:first_name], surname: params[:surname], email: params[:email])
    @user.password = params[:password]
    @user.save!
    return @user
  end

  def self.login(params)
    @user = first(email: params[:email])
    if @user && BCrypt::Password.new(@user.password_digest) == params[:password]
      return @user
    else
      nil
    end
  end

end
