class TheGame
  module Strategy
    class Multipliers < BaseStrategy
      def choose_item_and_player(players, jen, current_player)
        return [] if shielded?(jen)
        return [] if (item_types - jen.effects).length == 0

        item = find_item(jen.effects)
        return [] if item.nil?

        return [item, 'jheilema']
      end

      def find_item(effects)
        items = item_types - effects
        Item.unused.oldest.where(name: items).first
      end

      def item_types
        ['Warthog', 'Moogle', 'Rush the Dog', '7777']
      end

    private

      def shielded?(p)
        !(p.effects & (TheGame::ItemLibrary::PROTECTION - ['Varia Suit'] + ['Fus Ro Dah'])).empty?
      end
    end
  end
end
