module TheGame
  class ThingUser
    def initialize(thing, person = nil)
      @thing = thing
      @person = person
    end

    def do
      itemid = @thing[:Fields].first[:Id]
      if @person.nil?
        return do_to_nobody
      end

      player = @person[:PlayerName]
      path = "items/use/#{itemid}?target=#{player}"
      http = Curl.post("http://thegame.nerderylabs.com/#{path}") do |http|
        http.headers['apikey'] = API_KEY
      end

      begin
        JSON.parse(http.body_str, symbolize_names: true)
      rescue JSON::ParserError
        http.body_str
      end
    end

    def do_to_nobody
      itemid = @thing[:Fields].first[:Id]
      path = "items/use/#{itemid}"
      http = Curl.post("http://thegame.nerderylabs.com/#{path}") do |http|
        http.headers['apikey'] = API_KEY
      end

      begin
        JSON.parse(http.body_str, symbolize_names: true)
      rescue JSON::ParserError
        http.body_str
      end
    end
  end
end