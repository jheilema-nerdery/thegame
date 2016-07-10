class TheGame
  module Strategy
    class Prioritized
      def initialize(logger, api)
        @logger = logger
        @api = api
        @strategies = []
      end

      def use_items?
        true
      end

      def try_again_in
        10
      end

      def add_strategy(*strategy)
        @strategies.push(*strategy)
      end

      def choose_item_and_player(players, jen, username)
        @strategies.each do |strat|
          @logger.debug "Attempting strategy: #{strat}"
          strategy = ("TheGame::Strategy::" + strat).constantize.new(@logger, @api)
          result = strategy.choose_item_and_player(players, jen, username)
          return result unless result.empty? # break on the first one
          @logger.debug "#{strat} no good, trying another"
        end
        []
      end
    end
  end
end
