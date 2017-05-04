require 'data_mapper'
require_relative './app'

task default: %w[db:upgrade]

namespace :db do
  desc 'Destruction of data'
  task :migrate do
    DataMapper.auto_migrate!
    puts "Data destroyed!"
  end

  desc 'Non-destruction'
  task :upgrade do
    DataMapper.auto_upgrade!
    puts "No data destroyed!"
  end
end
