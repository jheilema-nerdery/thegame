module TheGame
  class TanookiSniper
    def initialize(logger, api)
      @logger = logger
      @api = api
      @players = []
      @effects = []
    end

    def time_to_wait
      60
    end

    def try_again_in
      10
    end

    def choose_item_and_player(current_effects = [], players)
      @players = players

      player = @players.find {|p| not_me(p) && has_tanooki_suit(p) }
      return [] if player.nil?
      @logger.debug "Player '#{player[:PlayerName]}' chosen"

      item = find_item
      return [] if item.nil?
      @logger.debug "Sniping #{item.name} chosen"

      return item, player[:PlayerName]
    end

  private

    def find_item
      Item.unused.oldest.where(name: ItemLibrary::PRICK).first
    end

    def not_me(p)
      p[:PlayerName] != 'jheilema'
    end

    def has_tanooki_suit(p)
      p[:Effects].include?("Tanooki Suit")
    end

  end
end
