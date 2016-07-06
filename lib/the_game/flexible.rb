module TheGame
  class Flexible
    def initialize(logger, api)
      @logger = logger
      @api = api
    end

    def time_to_wait
      60
    end

    def try_again_in
      55
    end

    def choose_item_and_player(effects=[], players)
      strategies = [
        Driveable,
        HoldingPattern
      ]

      strategies.each do |strat|
        result = strat.new(@logger, @api).choose_item_and_player(effects, players)
        return result unless result.empty? # break on the first one
      end
      []
    end
  end
end
