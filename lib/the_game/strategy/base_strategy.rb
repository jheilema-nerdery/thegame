class TheGame
  module Strategy
    class BaseStrategy
      def initialize(logger, api)
        @logger = logger
        @api = api
      end

      def successful_tick
        1.005
      end

      def failed_tick
        10
      end

      def starting_tick
        Time.now
      end

      def starting_attack(suggested)
        suggested
      end

      def use_items?
        true
      end

      def try_again_in
        1
      end

      def choose_item_and_player(players, jen, current_player)
        raise 'override in implementing class'
      end
    end
  end
end
