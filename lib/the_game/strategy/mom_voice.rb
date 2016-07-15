class TheGame
  module Strategy
    class MomVoice < BaseStrategy
      def initialize(logger, api)
        @logger  = logger
        @api     = api
        @players = []
        @jen     = nil
        @current = nil
        @fetcher = TheGame::PlayerFinder.new(@api)
      end

      def choose_item_and_player(players, jen, current_player)
        @players = @fetcher.fetch_leaderboard
        @jen = jen
        @current = current_player

        item = if !@current.wearing?('MomVoice')
          Item.unused.oldest.naed('Leisure Suit').first
        else
          Item.unused.oldest.named('Get Over Here').first
        end
        return [] if item.nil? # out of mom voice? whaaaat
        @logger.debug "#{item.name} chosen"

        player = choose_player(item)
        return [] if player.nil?
        @logger.debug "Player '#{player.name}' chosen"

        return item, player.name
      end

      def choose_player(item)
        if item.name == "Leisure Suit"
          return @current
        end

        sheildless = @players[0..5].find_all{|p| no_sheild(p) && p != @jen && p != @current }
        sheildless.first
      end

      def no_sheild(p)
        (p.effects & (TheGame::ItemLibrary::PROTECTION - ['Varia Suit', 'Carbuncle'])).empty?
      end
    end
  end
end
