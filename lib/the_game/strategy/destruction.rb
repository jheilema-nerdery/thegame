class TheGame
  module Strategy
    class Destruction < BaseStrategy
      def initialize(logger, api)
        @logger = logger
        @api = api
        @players = []
        @jen = nil
        @current = nil
      end

      def choose_item_and_player(players, jen, current_player)
        @players = players
        @jen = jen
        @current = current_player

        player = choose_player
        return [] if player.nil?
        @logger.debug "Player '#{player.name}' chosen"

        item = find_item(player)
        return [] if item.nil?
        @logger.debug "#{item.name} chosen"

        return item, player.name
      end

      def choose_player
        sheildless = @players.find_all{|p| no_sheild(p) && p != @jen && p != @current }[0..4]
        sheildless.sample
      end

      def find_item(player)
        item_types = ["Master Sword"]
        if player == @players[0]
          item_types << 'Blue Shell'
        end

        Item.unused.oldest.where(name: item_types).first
      end

      def no_sheild(p)
        (p.effects & (TheGame::ItemLibrary::PROTECTION - ['Varia Suit'] + ['Fus Ro Dah'])).empty?
      end
    end
  end
end
