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

      def choose_item_and_player(players, jen, username)
        return [] if jen.effects.include? 'Tanooki Suit'
        return [] if (jen.effects & (item_types)).length >= item_types.length

        item = find_item
        return [] if item.nil?

        @logger.debug "Multipliers: #{item.name} chosen"
        return [item, 'jheilema']
      end

      def find_item
        Item.unused.oldest.where(name: item_types).first
      end

      def item_types
        ['Warthog', 'Moogle', 'Rush the Dog']
      end
    end
  end
end
