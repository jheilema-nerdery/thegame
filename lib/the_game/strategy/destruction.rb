class TheGame
  module Strategy
    class Destruction
      def initialize(logger, api)
        @logger = logger
        @api = api
        @players = []
        @jen = nil
        @current = nil
      end

      def use_items?
        true
      end

      def try_again_in
        10
      end

      def choose_item_and_player(players, jen, current_player)
        @players = players
        @jen = jen
        @current = current_player

        if ( @players.first == @jen && percent_diff(@jen.points, @players.second.points) >= 0.4 )
          return []
        end

        player = choose_player
        return [] if player.nil?
        @logger.debug "Player '#{player.name}' chosen"

        item = find_item(player)
        return [] if item.nil?
        @logger.debug "#{item.name} chosen"

        return item, player.name
      end

      def choose_player
        sheildless = @players.find_all{|p| no_sheild(p) && p != @jen && p != @current }
        sheildless.first
      end

      def find_item(player)
        item_types = ItemLibrary::BIG_GUN
        item_types -= player.effects

        unless @players.include? @current
          item_types += 'Get Over Here'
        end

        Item.unused.oldest.where(name: item_types).first
      end

      def no_sheild(p)
        (p.effects & (TheGame::ItemLibrary::PROTECTION - ['Varia Suit'])).empty?
      end

      def percent_diff(first, second)
        (first.to_f - second) / first
      end
    end
  end
end
