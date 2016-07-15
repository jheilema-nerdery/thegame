class TheGame
  module Strategy
    class MomVoice < BaseStrategy
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

        item = if !@current_player.wearing?('MomVoice')
          Item.unused.oldest.where(name: 'Leisure Suit').first
        else
          Item.unused.oldest.where(name: 'Get Over Here').first
        end
        return [] if item.nil? # out of mom voice? whaaaat
        @logger.debug "#{item.name} chosen"

        player = choose_player
        return [] if player.nil?
        @logger.debug "Player '#{player.name}' chosen"

        return item, player.name
      end

      def choose_player
        sheildless = @players.find_all{|p| no_sheild(p) && p != @jen && p != @current }[0..3]
        sheildless.sample
      end

      def no_sheild(p)
        (p.effects & (TheGame::ItemLibrary::PROTECTION - ['Varia Suit', 'Carbuncle'])).empty?
      end

      def percent_diff(first, second)
        (first.to_f - second) / first
      end
    end
  end
end
