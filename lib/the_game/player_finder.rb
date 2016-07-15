class TheGame
  class PlayerFinder
    attr_reader :players, :leaders, :jen

    def initialize(api)
      @api = api
      @leaders =[]
      @jen = nil
    end

    def get_player(handle)
      @players[handle]
    end

    def fetch_leaderboard
      players_data = @api.players

      if @api.errors?
        # keep working with the old data.
        return
      end
      @leaders = ::Player.all_from_json players_data
    end

    def fetch_jen
      jen_data = @api.jen

      if @api.errors?
        # keep working with the old data.
        return
      end
      @jen = ::Player.new jen_data
    end

    def fetch_players(players)
      players.each do |player|
        data = @api.player(player.username)
        unless @api.errors?
          @players[username] = ::Player.new data
        end
      end
    end

  end
end
