require "uri"
require "net/https"
require "json"

module Latest
  class Gem
    
    attr_reader :name, :versions
    
    def initialize(name)
      @name       = name
      @versions   = fetch
      if @versions.nil? || @versions.empty?
        raise ::Latest::GemNotFoundError, "`#{name}` could not be found on rubygems.org!"
      end
      self
    end
    
    def last_prerelease_version
      return @last_prerelease_version if @last_prerelease_version
      @last_prerelease_version = find_latest_version(true)
    end
    
    def last_stable_version
      return @last_stable_version if @last_stable_version
      @last_stable_version = find_latest_version
    end

  private
  
    def find_latest_version(prerelease=false)
      version = "(not found)"
      @versions.each do |v|
        next unless v["prerelease"] == prerelease
        version = v["number"]
        break
      end
      version
    end
  
    def fetch
      uri = URI("https://rubygems.org/api/v1/versions/#{@name}.json")
      Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
        request = Net::HTTP::Get.new uri.request_uri      
        response = http.request request
        if response.is_a?(Net::HTTPSuccess)
          return JSON.parse(response.body)
        end
      end
    end
    
  end
end
