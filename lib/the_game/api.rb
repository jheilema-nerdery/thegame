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

    def jen
      get('points/jheilema')
    end

  private

    def get(path)
      curl(:get, path) do |http|
        http.headers['Accept'] = 'application/json'
        http.timeout = 5
      end
    end

    def post(path)
      curl(:post, path) do |http|
        http.timeout = 5
        http.headers['apikey'] = @key
      end
    end

    def curl(action, path, &block)
      url = "http://thegame.nerderylabs.com/#{path}"

      @logger.debug "#{action.upcase} /#{path}"

      response = begin
        result = Curl.send(action, url, &block).body_str
      rescue Curl::Err::CurlError => e
        return "*"*10 +
          "  #{action.upcase} /#{path}  ****  " +
          "#{e.class} : #{e.message}  " +
          "*"*10
      end

      @logger.debug "#{action.upcase} /#{path} - #{response}"

      process response
    end

  private
    def process(response)
      result = begin
        JSON.parse(response, symbolize_names: true)
      rescue JSON::ParserError
        response
      end

      get_bonuses(result[:Messages]) if result.is_a?(Hash) && result[:Messages]
      result
    end

    # check for bonus items and save them
    # {
    #   :Messages=>[
    #     "You used <Da Da Da Da Daaa Da DAA da da> on jheilema; 10 points for jheilema!",
    #     "You found a bonus item! <c4ea419c-88a7-4f99-a8e8-576cfcf5ca67> | <Hard Knuckle>"
    #   ], :TargetName=>"jheilema", :Points=>23807
    # }
    def get_bonuses(messages)
      regex = /<([\w]{8}-[\w]{4}-[\w]{4}-[\w]{4}-[\w]{12})> \| <([\w ]*)>/
      bonuses = messages.select {|m| m =~ regex }
      bonuses.each do |bonus_message|
        matches = bonus_message.match(regex).captures
        Item.create(api_id: matches[0], name: matches[1])
      end
    end
  end
end
