class TheGame
  module Strategy
    class TanookiSniper < BaseStrategy
      def choose_item_and_player(players, jen, username)
        player = players.find {|p| p != jen && has_tanooki_suit(p) }
        return [] if player.nil?
        @logger.debug "Player '#{player.name}' chosen"

        item = find_item
        return [] if item.nil?
        @logger.debug "Sniping #{item.name} chosen"

        return item, player.name
      end

    private

      def find_item
        Item.unused.oldest.where(name: ItemLibrary::PRICK + ["Bo Jackson"]).first
      end

      def has_tanooki_suit(p)
        p.effects.include?("Tanooki Suit")
      end

    end
  end
end
