module Latest
  class Gem
    
    attr_reader :attributes
    
    def initialize(name)
      @attributes = fetch(name)
      if @attributes.nil?
        raise ::Latest::GemNotFoundError, "`#{name}` could not be found on rubygems.org!"
      end
      super
    end
    
  private
  
    def fetch(name)
      uri = URI("https://rubygems.org/api/v1/gems/#{name}.json")
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
