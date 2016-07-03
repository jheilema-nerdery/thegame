module TheGame
  class Api
    def initialize(logger, key)
      @logger = logger
      @key = key
    end

    def post_points
      response = Curl.post("http://thegame.nerderylabs.com/points") do |http|
        http.headers['apikey'] = @key
      end
      @logger.info response.body_str
      JSON.parse(response.body_str, symbolize_names: true)
    end
  end
end
