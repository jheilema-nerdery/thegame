class TheGame
  module Strategy
    class Offensive
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

      def choose_item_and_player(players, jen, current)
        @players = players
        @jen = jen
        @current = @current

        player = choose_player
        return [] if player.nil?
        @logger.debug "Player '#{player.name}' chosen"

        item = find_item(player)
        return [] if item.nil?
        @logger.debug "#{item.name} chosen"

        return item, player.name
      end

      def choose_player
        sheildless = @players.find_all{|p| no_sheild(p) && p != @current }
        sheildless.find{|p| has_multipliers(p) && !has_hadouken(p) } || sheildless.sample
      end

      def find_item(player)
        item_types = ItemLibrary::WEAPON

        if has_multipliers(player) && !has_hadouken(player)
          item_types = ['Hadouken']
        end

        if player == @jen
          item_types = ItemLibrary::PRICK
        end

        item_types -= player.effects

        Item.unused.oldest.where(name: item_types).first
      end

      def has_hadouken(player)
        player.effects.include?('Hadouken')
      end

      def has_multipliers(player)
        (player.effects & ItemLibrary::MULTIPLIER).length > 0
      end

      def no_sheild(p)
        (p.effects & TheGame::ItemLibrary::PROTECTION - ["Varia Suit"]).empty?
      end

    end
  end
end
