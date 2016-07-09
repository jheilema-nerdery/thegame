class TheGame
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
      5
    end

    def choose_item_and_player(players, jen)
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
      @players.find {|p| no_sheild(p) }
    end

    def find_item(player)
      item_types = ItemLibrary::WEAPON

      if is_me(player)
        item_types = ItemLibrary::PRICK
      end

      item_types -= player[:Effects]

      Item.unused.oldest.where(name: item_types).first
    end

    def is_me(p)
      p[:PlayerName] == 'jheilema'
    end

    def no_sheild(p)
      (p[:Effects] & TheGame::ItemLibrary::PROTECTION).empty?
    end

  end
end
