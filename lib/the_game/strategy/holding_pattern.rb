class TheGame
  module Strategy
    class HoldingPattern
      def initialize(logger, api)
        @logger = logger
        @api = api
        @players = []
        @effects = []
        @jen = nil
      end

      def use_items?
        true
      end

      def try_again_in
        5
      end

      def choose_item_and_player(players, jen, current_player)
        @players = players
        @jen = jen

        item = find_item

        return [] if item.nil?
        @logger.debug "#{item.name} chosen"

        if ItemLibrary::ALL_POSITIVE.include? item.name
          @logger.debug "Applying #{item.name} to me"
          return item, 'jheilema'
        end

        player = @players.find {|p| p != @jen && no_sheild(p) && not_stacking(item, p) }
        @logger.debug "Player '#{player.name}' chosen"

        return item, player.name
      end

    private

      def find_item
        item_types = ItemLibrary::WEAPON

        unless @jen.effects.include? "Tanooki Suit"
          item_types += positive_effects
        end

        if @players.first != @jen
          item_types = item_types + ItemLibrary::CLOSE_RANGE
        end

        Item.unused.oldest.where(name: item_types).first
      end

      def no_sheild(p)
        (p.effects & TheGame::ItemLibrary::PROTECTION).empty?
      end

      def not_stacking(item, p)
        !p.effects.include?(item.name)
      end

      def in_top_ten?(player_name)
        @players.any?{|p| p.name == player_name}
      end

      def less_than_3_multipliers
        (@effects & ItemLibrary::MULTIPLIER).length < 3
      end

      def positive_effects
        positive_items = ItemLibrary::POSITIVE

        # try to stay in the top 10    # but don't use too many items
        if !in_top_ten?('jheilema') && less_than_3_multipliers
          nice_effects = ItemLibrary::MULTIPLIER -
                        ['7777'] -  # not the fanciest one
                        @effects    # not any that we already have
          positive_items += nice_effects
        end

        positive_items
      end

    end
  end
end
