module TheGame
  class FakeApi
    def initialize(logger, key)
      @logger = logger
      @key = key
    end

    def points
      post('points')
          Rails.logger.debug points
      {:Messages=>["sbausch gained 1 points! Total points: 38"], :Item=>nil, :Points=>38, :Effects=>[], :Badges=>[]}
    end

    def use(item)
      post("items/use/#{item}")
      {}
    end

    def use_on(item, person)
      post("items/use/#{item}?target=#{person}")
      {}
    end

    def players
      post("/")
      []
    end

  private

    def post(path)
      puts path
    end

  end
end
