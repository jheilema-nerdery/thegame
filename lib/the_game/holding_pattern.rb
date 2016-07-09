class TheGame
  class HoldingPattern
    def initialize(logger, api)
      @logger = logger
      @api = api
      @players = []
      @effects = []
    end

    def use_items?
      true
    end

    def try_again_in
      5
    end

    def choose_item_and_player(current_effects = [], players, points)
      @players = players
      @effects = current_effects

      item = find_item

      return [] if item.nil?
      @logger.debug "#{item.name} chosen"

      if ItemLibrary::ALL_POSITIVE.include? item.name
        @logger.debug "Applying #{item.name} to me"
        return item, 'jheilema'
      end

      player = @players.find {|p| not_me(p) && no_sheild(p) && not_stacking(item, p) }
      @logger.debug "Player '#{player[:PlayerName]}' chosen"

      return item, player[:PlayerName]
    end

  private

    def find_item
      item_types = ItemLibrary::WEAPON

      unless @effects.include? "Tanooki Suit"
        item_types += positive_effects
      end

      if @players[0][:PlayerName] != 'jheilema'
        item_types = item_types + ItemLibrary::CLOSE_RANGE
      end

      Item.unused.oldest.where(name: item_types).first
    end

    def not_me(p)
      p[:PlayerName] != 'jheilema'
    end

    def no_sheild(p)
      (p[:Effects] & TheGame::ItemLibrary::PROTECTION).empty?
    end

    def not_stacking(item, p)
      !p[:Effects].include?(item.name)
    end

    def in_top_ten?(player_name)
      @players.any?{|p| p[:PlayerName] == player_name}
    end

    def less_than_3_multipliers
      (@effects & ItemLibrary::EFFECT_OVER_TIME).length < 3
    end

    def positive_effects
      positive_items = ItemLibrary::POSITIVE

      # try to stay in the top 10    # but don't use too many items
      if !in_top_ten?('jheilema') && less_than_3_multipliers
        nice_effects = ItemLibrary::EFFECT_OVER_TIME -
                      ['7777'] -  # not the fanciest one
                      @effects    # not any that we already have
        positive_items += nice_effects
      end

      positive_items
    end

  end
end
