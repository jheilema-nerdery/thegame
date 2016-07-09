class TheGame
  class Flexible
    def initialize(logger, api)
      @logger = logger
      @api = api
    end

    def use_items?
      true
    end

    def try_again_in
      10
    end

    def choose_item_and_player(effects, players, points)
      strategies = [
        'TheGame::Driveable',
        'TheGame::HoldingPattern'
      ]


      strategies.each do |strat|
        strategy = strat.constantize.new(@logger, @api)
        result = strategy.choose_item_and_player(effects, players, points)
        return result unless result.empty? # break on the first one
      end
      []
    end
  end
end
