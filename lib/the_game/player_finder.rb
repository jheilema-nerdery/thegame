module TheGame
  class PlayerFinder
    def initialize(api)
      @api = api
    end

    def find_top
      @api.players
    end
  end
end
