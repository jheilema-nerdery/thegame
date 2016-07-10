class TheGame
  module Strategy
    class Destruction
      def initialize(logger, api)
        @logger = logger
        @api = api
        @players = []
      end

      def use_items?
        true
      end

      def try_again_in
        10
      end

      def choose_item_and_player(players, jen, username)
        @players = players

        player = choose_player
        return [] if player.nil?
        @logger.debug "Player '#{player[:PlayerName]}' chosen"

        item = find_item(player)
        return [] if item.nil?
        @logger.debug "#{item.name} chosen"

        return item, player[:PlayerName]
      end

      def choose_player
        sheildless = @players.find_all{|p| !sheilded(p) && !is_me(p) }
        sheildless.first
      end

      def find_item(player)
        item_types = ItemLibrary::BIG_GUN
        item_types -= player[:Effects]

        Item.unused.oldest.where(name: item_types).first
      end

      def is_me(p)
        p[:PlayerName] == 'jheilema'
      end

      def sheilded(p)
        !(p[:Effects] & (TheGame::ItemLibrary::PROTECTION - ['Varia Suit'])).empty?
      end

    end
  end
end
