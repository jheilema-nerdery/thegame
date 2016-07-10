class TheGame
  module Strategy
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

      def choose_item_and_player(players, jen)
        strategies = [
          'TheGame::Strategy::Driveable',
          'TheGame::Strategy::HoldingPattern'
        ]

        strategies.each do |strat|
          strategy = strat.constantize.new(@logger, @api)
          result = strategy.choose_item_and_player(players, jen)
          return result unless result.empty? # break on the first one
        end
        []
      end
    end
  end
end
