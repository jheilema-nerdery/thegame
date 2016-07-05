module TheGame
  class Api
    def initialize(logger, key)
      @logger = logger
      @key = key
    end

    def tick
      post('points')
    end

    def use(item)
      post("items/use/#{item}")
    end

    def use_on(item, person)
      post("items/use/#{item}?target=#{person}")
    end

    def players
      get('')
    end

  private

    def get(path)
      url = "http://thegame.nerderylabs.com/#{path}"

      response = Curl.get(url) do |http|
        http.headers['apikey'] = @key
        http.headers['Accept'] = 'application/json'
      end
      @logger.debug response.body_str

      result = begin
        JSON.parse(response.body_str, symbolize_names: true)
      rescue JSON::ParserError
        response.body_str
      end

      process result
      result
    end

    def post(path)
      url = "http://thegame.nerderylabs.com/#{path}"

      response = Curl.post(url) do |http|
        http.headers['apikey'] = @key
      end
      @logger.debug response.body_str

      result = begin
        JSON.parse(response.body_str, symbolize_names: true)
      rescue JSON::ParserError
        response.body_str
      end

      process result
      result
    end

  private
    def process(result)
      return if result.is_a? String

      get_bonuses(result[:Messages]) if result.is_a?(Hash)
    end

    # check for bonus items and save them
    def get_bonuses(messages)
      # {:Messages=>["You used <Da Da Da Da Daaa Da DAA da da> on jheilema; 10 points for jheilema!", "You found a bonus item! <c4ea419c-88a7-4f99-a8e8-576cfcf5ca67> | <Hard Knuckle>"], :TargetName=>"jheilema", :Points=>23807}
      bonuses = messages.select {|m| m =~ /^You found a bonus item/ }
      bonuses.each do |bonus_message|
        matches = bonus_message.match(/<([\w]{8}-[\w]{4}-[\w]{4}-[\w]{4}-[\w]{12})> \| <([\w ]*)>/).captures
        Item.create(api_id: matches[0], name: matches[1])
      end

    end
  end
end
