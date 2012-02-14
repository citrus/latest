require "latest/version"
require "latest/gem"

module Latest
  
  class GemNotFoundError < StandardError; end
  
  def self.version(name)
    gem = Gem.new(name)
    gem.attributes["version"]
  end
  
end
