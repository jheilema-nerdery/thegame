class TheGame
  module Strategy
    class Presents < BaseStrategy
      def choose_item_and_player(players, jen, current_user)
        return [] if current_user.effects.include?('Tanooki Suit')

        item = find_item
        return [] if item.nil?
        @logger.debug "Presents: #{item.name} chosen"

        return [item, current_user.name]
      end

      def find_item
        item_types = ItemLibrary::PRESENTS
        Item.unused.oldest.where(name: item_types).first
      end
    end
  end
end
