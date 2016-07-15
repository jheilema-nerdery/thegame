class TheGame
  module Strategy
    class PortalGun < BaseStrategy
      def initialize(logger, api)
        @logger = logger
        @api = api
        @players = []
        @jen = nil
      end

      def choose_item_and_player(players, jen, current_player)
        @players = players
        @jen = jen

        index = @players.find_index(@jen)
        return [] if index == 1 || index == 0 # I'm in first/second, yay!

        player = find_player
        return [] if item.nil?
        @logger.debug "#{player.name} chosen"

        item = find_item
        return [] if item.nil?
        @logger.debug "#{item.name} chosen"

        return item, player.name
      end

    private

      def find_player
        @players.drop(1).find_all{|p| p != @jen && !sheilded?(p) }.first
      end

      def find_item
        Item.unused.oldest.where(name: 'Portal Gun').first
      end

      def sheilded?(player)
        player.wearing?(['Star','Gold Ring','Tanooki Suit','Morger Beard'])
      end

      def too_close(player)
        player.score >= (::SUSPICIOUS_POINTS - points_left)
      end

      def points_left
        (Time.now - ::FINALE).to_i
      end

    end
  end
end
