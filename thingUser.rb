require 'curb'

class ThingUser
  def initialize(thing, person)
    @thing = thing
    @person = person
  end

  def do
    itemid = @thing[:Fields].first[:Id]
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
end
