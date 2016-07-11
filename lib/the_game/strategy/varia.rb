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

      def choose_item_and_player(players, jen, current_player)
        return [] if jen.effects.include? 'Tanooki Suit'
        return [] if (item_types - jen.effects).length == 0

        item = find_item(jen.effects)
        return [] if item.nil?

        @logger.debug "Suits: #{item.name} chosen"
        return [item, 'jheilema']
      end

      def find_item(effects)
        items = item_types - effects
        Item.unused.oldest.where(name: item_types).first
      end

      def item_types
        ['Varia Suit']
      end
    end
  end
end
