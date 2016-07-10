class TheGame
  module Strategy
    class Varia
      def initialize(logger, api)
        @logger = logger
        @api = api
      end

      def use_items?
        true
      end

      def try_again_in
        5
      end

      def choose_item_and_player(players, jen, username)
        return [] if jen[:Effects].include?(item_types + 'Tanooki Suit')

        item = find_item
        return [] if item.nil?

        @logger.debug "Suits: #{item.name} chosen"
        return [item, 'jheilema']
      end

      def find_item
        Item.unused.oldest.where(name: item_types).first
      end

      def item_types
        ['Varia Suit']
      end
    end
  end
end
