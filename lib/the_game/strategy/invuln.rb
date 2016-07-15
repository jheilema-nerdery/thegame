class TheGame
  module Strategy
    class Invuln < BaseStrategy
      def choose_item_and_player(players, jen, current_player)
        return [] if jen.effects.include? 'Tanooki Suit'

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
