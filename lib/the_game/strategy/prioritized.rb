class TheGame
  module Strategy
    class Prioritized < BaseStrategy
      def initialize(logger, api)
        @logger = logger
        @api = api
        @strategies = []
      end

      def add_strategy(*strategy)
        @strategies.push(*strategy)
      end

      def choose_item_and_player(players, jen, current_player)
        @strategies.each do |strat|
          @logger.debug "Attempting strategy: #{strat}"
          strategy = ("TheGame::Strategy::" + strat).constantize.new(@logger, @api)
          result = strategy.choose_item_and_player(players, jen, current_player)
          return result unless result.empty? # break on the first one
          @logger.debug "#{strat} no good, trying another"
        end
        []
      end
    end
  end
end
