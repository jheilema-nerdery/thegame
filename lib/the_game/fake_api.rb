class TheGame
  class FakeApi
    def initialize(logger, key)
      @logger = logger
      @key = key
    end

    def tick
      post('points')
      {:Messages=>["jheilema gained 1 points! Total points: 38"], :Item=>nil, :Points=>38, :Effects=>[], :Badges=>[]}
    end

    def use(item)
      post("items/use/#{item}")
      {:Messages=>["You used <SPNKR> on jheilema; -100 points for jheilema!"], :TargetName=>"jheilema", :Points=>29323}
    end

    def use_on(item, person)
      post("items/use/#{item}?target=#{person}")
      {:Messages=>["You used <SPNKR> on jmullin; -100 points for jmullin!"], :TargetName=>"jmullin", :Points=>29323}
    end

    def players
      post("/")
      [
        {:PlayerName=>"bliset", :AvatarUrl=>"https://lh6.googleusercontent.com/photo.jpg", :Points=>90829, :Title=>"", :Effects=>["Hadouken", "Moogle"], :Badges=>[{:BadgeName=>"Pony"}, {:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Chocobo"}, {:BadgeName=>"Plunger"}]},
        {:PlayerName=>"wkallhof", :AvatarUrl=>"https://lh4.googleusercontent.com/photo.jpg", :Points=>90761, :Title=>"", :Effects=>["Slow", "Hadouken"], :Badges=>[{:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Plunger"}, {:BadgeName=>"Simon's Quest Badge"}]},
        {:PlayerName=>"meastes", :AvatarUrl=>"https://lh6.googleusercontent.com/--8IpHzOwVmY/AAAAAAAAAAI/AAAAAAAAAC8/d2u1Ywr4gks/photo.jpg", :Points=>88567, :Title=>"", :Effects=>[], :Badges=>[{:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Pony"}, {:BadgeName=>"Chocobo"}]},
        {:PlayerName=>"nhotalli", :AvatarUrl=>"https://lh3.googleusercontent.com/photo.jpg", :Points=>81255, :Title=>"", :Effects=>["Hadouken", "Moogle"], :Badges=>[{:BadgeName=>"Chocobo"}, {:BadgeName=>"Simon's Quest Badge"}, {:BadgeName=>"Pony"}, {:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Fat Guys"}, {:BadgeName=>"Plunger"}]},
        {:PlayerName=>"revans", :AvatarUrl=>"https://lh4.googleusercontent.com/photo.jpg", :Points=>81226, :Title=>"", :Effects=>[], :Badges=>[{:BadgeName=>"Simon's Quest Badge"}, {:BadgeName=>"Plunger"}, {:BadgeName=>"Pony"}]}
      ]
    end

    def jen
      post('points/jheilema')
      {:PlayerName=>"jheilema",:AvatarUrl =>"https://lh6.googleusercontent.com/photo.jpg","Badges":[{:BadgeName=>"Vampire"},{:BadgeName=>"Power Pellet: Pinky"},{:BadgeName=>"Power Pellet: Blinky"},{:BadgeName=>"Chocobo"},{:BadgeName=>"Simon's Quest Badge"},{:BadgeName=>"Plunger"},{:BadgeName=>"Pony"}],:Effects=>["Rush the Dog","Warthog","Moogle","Varia Suit","Lycanthropy","Vampirism"],:Title =>"aka Pinky",:Points=>210139,:ItemsGained=>0,:ItemsUsed=>1}
    end

  private

    def post(path)
      puts path
    end

  end
end
