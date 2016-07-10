class TheGame
  module Strategy
    class RoundRobin
      def initialize(logger, api)
        @logger = logger
        @api = api
        @strategies = []
        @index = 0
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
        @strategies.each do |i|
          strategy = ("TheGame::Strategy::" + next_strategy).constantize.new(@logger, @api)
          result = strategy.choose_item_and_player(players, jen, username)
          increment_index

          return result unless result.empty? # break on the first one
        end

        return []
      end

      private

      def next_strategy
        @strategies[@index]
      end

      def increment_index
        @index += 1
        @index = 0 if @index == @strategies.length
      end

    end
  end
end
