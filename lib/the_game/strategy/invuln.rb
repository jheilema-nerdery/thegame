class TheGame
  module Strategy
    class Invuln < BaseStrategy
      def try_again_in
        5
      end

      def choose_item_and_player(players, jen, current_player)
        return [] if jen.effects.include? 'Tanooki Suit'
        # give the multipliers some time to work, don't put an invuln item on
        # until all are on
        return [] if (ItemLibrary::MULTIPLIER - jen.effects).length > 0

        item = find_item(jen.effects)
        return [] if item.nil?

        return [item, 'jheilema']
      end

      def find_item(effects)
        return nil if (item_types - effects).length == 0
        Item.unused.oldest.where(name: item_types - effects).first
      end

      def item_types
        ['Star', 'Gold Ring', 'Morger Beard']
      end
    end
  end
end
