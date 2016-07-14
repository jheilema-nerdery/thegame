class TheGame
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

    def player(username)
      get("points/#{username}")
    end

    def effects(username)
      get("effects/#{username}")
    end

    def errors?
      @errors
    end

  private

    def get(path)
      curl(:get, path) do |http|
        http.headers['Accept'] = 'application/json'
        http.timeout = 10
      end
    end

    def post(path)
      curl(:post, path) do |http|
        http.timeout = 15
        http.headers['apikey'] = @key
      end
    end

    def curl(action, path, &block)
      @errors = false
      url = "http://thegame.nerderylabs.com:1337/#{path}"

      @logger.debug "#{action.upcase} /#{path}"

      response = begin
        result = Curl.send(action, url, &block).body_str
      rescue Curl::Err::CurlError => e
        @errors = true
        return "#{action.upcase} /#{path}  ****  " +
          "#{e.class} : #{e.message}  "
      end

      @logger.debug "#{action.upcase} /#{path} - #{response}"

      parsed = parse(response)
      get_bonuses(parsed[:Messages]) if parsed.is_a?(Hash) && parsed[:Messages]
      parsed
    end

  private
    def parse(response)
      begin
        JSON.parse(response, symbolize_names: true)
      rescue JSON::ParserError
        @errors = true
        response
      end
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
