class TheGame
  module Strategy
    class Multipliers
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
        return [] unless (item_types - jen.effects).length > 0

        item = find_item(jen.effects)
        return [] if item.nil?

        return [item, 'jheilema']
      end

      def find_item(effects)
        items = item_types - effects
        Item.unused.oldest.where(name: items).first
      end

      def item_types
        ['Warthog', 'Moogle', 'Rush the Dog']
      end
    end
  end
end
