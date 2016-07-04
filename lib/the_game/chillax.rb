module TheGame
  class Chillax
    def initialize(logger, api)
      @logger = logger
      @api = api
    end

    def time_to_wait
      7 # doesn't matter
    end

    def choose_item_and_player(effects=[])
      []
    end
  end
end
