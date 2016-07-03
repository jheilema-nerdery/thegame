module TheGame
  class PlayerFinder
    def self.find_top
      http = Curl.get("http://thegame.nerderylabs.com/") do |http|
        http.headers['apikey'] = API_KEY
        http.headers['Accept'] = 'application/json'
      end
      JSON.parse(http.body_str, symbolize_names: true)
    end
  end
end
