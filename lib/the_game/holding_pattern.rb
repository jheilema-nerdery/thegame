module TheGame
  class HoldingPattern
    def initialize(logger, api)
      @logger = logger
      @api = api
    end

    def time_to_wait
      60
    end

    def choose_item_and_player(current_effects = [])
      players = @api.players
      item = find_item(players, current_effects)

      return [] if item.nil?
      @logger.debug "#{item.name} chosen"

      if ItemLibrary::POSITIVE.include? item.name
        @logger.debug "Applying #{item.name} to me"
        return item, { :PlayerName => 'jheilema' }
      end

      player = players.find {|p| not_me(p) && no_sheild(p) }
      @logger.debug "Player '#{player[:PlayerName]}' chosen"

      return item, player
    end

  private

    def not_me(p)
      p[:PlayerName] != 'jheilema'
    end

    def no_sheild(p)
      (p[:Effects] & TheGame::ItemLibrary::PROTECTION).empty?
    end

    def find_item(players, current_effects)
      item_types = ItemLibrary::WEAPON

      unless current_effects.include? "Tanooki Suit"
        item_types = item_types + ItemLibrary::POSITIVE
      end

      if players[0][:PlayerName] != 'jheilema'
        item_types = item_types + ItemLibrary::CLOSE_RANGE
      end

      Item.unused.oldest.where(name: item_types).first
    end

  private

  end
end
