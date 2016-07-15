class TheGame
  module Strategy
    class Rekt < BaseStrategy
      def initialize(logger, api)
        @logger  = logger
        @api     = api
        @players = []
        @jen     = nil
        @current = nil
        @fetcher = TheGame::PlayerFinder.new(@api)
      end

      def choose_item_and_player(players, jen, current_player)
        if Time.now < CRAZY_TIME
          return []
        end

        @players = @fetcher.fetch_leaderboard
        @jen = jen
        @current = current_player

        item = Item.unused.oldest.named('Wreck It Ralph').first
        return [] if item.nil? # out of ralphs, oh well=
        @logger.debug "#{item.name} chosen"

        player = choose_player
        return [] if player.nil?
        @logger.debug "Player '#{player.name}' chosen"

        return item, player.name
      end

      def choose_player
        sheilded = @players.find_all{|p| p != @jen && p != @current }
        sheilded.first
      end

      def sheilded?(p)
        !(p.effects & (TheGame::ItemLibrary::PROTECTION - ['Varia Suit'])).empty?
      end
    end
  end
end
