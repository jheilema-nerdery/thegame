module TheGame
  class Chillax
    def initialize(logger, api)
      @logger = logger
      @api = api
    end

    def time_to_wait
      420 # doesn't matter
    end

    def choose_item_and_player(effects=[], players)
      []
    end
  end
end
