class TheGame
  module Strategy
    class Flexible < BaseStrategy
      def choose_item_and_player(players, jen, current_player)
        strategies = [
          'TheGame::Strategy::Driveable',
          'TheGame::Strategy::HoldingPattern'
        ]

        strategies.each do |strat|
          strategy = strat.constantize.new(@logger, @api)
          result = strategy.choose_item_and_player(players, jen, current_player)
          return result unless result.empty? # break on the first one
        end
        []
      end
    end
  end
end
