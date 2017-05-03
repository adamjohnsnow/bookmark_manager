require_relative 'link'

class Tag
  include DataMapper::Resource
  property :id, Serial
  property :name, String

  has n, :links, through: Resource

  def self.split_tags(tags)
    array = []
    tags.split(',').each { |tag| array << Tag.first_or_create(name: tag.strip) }
    return array
  end
end
