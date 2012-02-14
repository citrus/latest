require "latest/version"
require "latest/gem"

module Latest
  
  class GemNotFoundError < StandardError; end
  
  def self.lookup(name)
    gem = Gem.new(name)
    gem
  end
  
end
