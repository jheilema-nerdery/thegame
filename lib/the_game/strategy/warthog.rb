class TheGame
  module Strategy
    class Warthog
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
        return [] unless (jen.effects & (item_types + ['Tanooki Suit'])).empty?

        item = find_item
        return [] if item.nil?

        @logger.debug "Warthog: #{item.name} chosen"
        return [item, 'jheilema']
      end

      def find_item
        Item.unused.oldest.where(name: item_types).first
      end

      def item_types
        ['Warthog']
      end
    end
  end
end
