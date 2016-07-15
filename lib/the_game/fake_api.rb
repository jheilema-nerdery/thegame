class TheGame
  class FakeApi
    def initialize(logger, key)
      @logger = logger
      @key = key

      @players = [[
        {:PlayerName=>"bliset", :Points=>90829, :Title=>"", :Effects=>["Hadouken", "Moogle"], :Badges=>[{:BadgeName=>"Pony"}, {:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Chocobo"}, {:BadgeName=>"Plunger"}]},
        {:PlayerName=>"wkallhof", :Points=>90761, :Title=>"", :Effects=>["Slow", "Hadouken"], :Badges=>[{:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Plunger"}, {:BadgeName=>"Simon's Quest Badge"}]},
        {:PlayerName=>"meastes", :Points=>88567, :Title=>"", :Effects=>[], :Badges=>[{:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Pony"}, {:BadgeName=>"Chocobo"}]}
        ],
        [
        {:PlayerName=>"revans", :Points=>81226, :Title=>"", :Effects=>[], :Badges=>[{:BadgeName=>"Simon's Quest Badge"}, {:BadgeName=>"Plunger"}, {:BadgeName=>"Pony"}]},
        {:PlayerName=>"nhotalli", :Points=>81255, :Title=>"", :Effects=>["Hadouken", "Moogle"], :Badges=>[{:BadgeName=>"Chocobo"}, {:BadgeName=>"Simon's Quest Badge"}, {:BadgeName=>"Pony"}, {:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Fat Guys"}, {:BadgeName=>"Plunger"}]},
        {:PlayerName=>"revans", :Points=>81226, :Title=>"", :Effects=>[], :Badges=>[{:BadgeName=>"Simon's Quest Badge"}, {:BadgeName=>"Plunger"}, {:BadgeName=>"Pony"}]}
        ],
        [
        {:PlayerName=>"nhotalli", :Points=>81255, :Title=>"", :Effects=>["Hadouken", "Moogle"], :Badges=>[{:BadgeName=>"Chocobo"}, {:BadgeName=>"Simon's Quest Badge"}, {:BadgeName=>"Pony"}, {:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Fat Guys"}, {:BadgeName=>"Plunger"}]},
        {:PlayerName=>"revans", :Points=>81226, :Title=>"", :Effects=>[], :Badges=>[{:BadgeName=>"Simon's Quest Badge"}, {:BadgeName=>"Plunger"}, {:BadgeName=>"Pony"}]},
        {:PlayerName=>"wkallhof", :Points=>90761, :Title=>"", :Effects=>["Slow", "Hadouken"], :Badges=>[{:BadgeName=>"Skinny Guys"}, {:BadgeName=>"Plunger"}, {:BadgeName=>"Simon's Quest Badge"}]},
        ]
      ].cycle
    end

    def errors?
      false
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
      {:Messages=>["You used <SPNKR> on #{person}; -100 points for jmullin!"], :TargetName=>person, :Points=>29323}
    end

    def player(username)
      post("points/#{username}")
      {:PlayerName=>username, :AvatarUrl=>"https://lh4.googleusercontent.com/photo.jpg", :Points=>81226, :Title=>"", :Effects=>[], :Badges=>[{:BadgeName=>"Simon's Quest Badge"}, {:BadgeName=>"Plunger"}, {:BadgeName=>"Pony"}]}
    end

    def players
      post("/")
      @players.next
    end

    def jen
      post('points/jheilema')
      {:PlayerName=>"jheilema",:AvatarUrl =>"https://lh6.googleusercontent.com/photo.jpg","Badges":[{:BadgeName=>"Vampire"},{:BadgeName=>"Power Pellet: Pinky"},{:BadgeName=>"Power Pellet: Blinky"},{:BadgeName=>"Chocobo"},{:BadgeName=>"Simon's Quest Badge"},{:BadgeName=>"Plunger"},{:BadgeName=>"Pony"}],:Effects=>["Rush the Dog","Warthog","Moogle","Varia Suit","Lycanthropy","Vampirism"],:Title =>"aka Pinky",:Points=>210139,:ItemsGained=>0,:ItemsUsed=>1}
    end

    def effects(username)
      post("effects/#{username}")
      [
        {
          :Timestamp => "2016-07-11T05:31:27.9101299Z",
          :Creator => "revans",
          :Targets => username,
          :Effect => {
            :EffectName => "Hard Knuckle",
            :EffectType => "Attack",
            :Duration => { :Case => "Instant"},
            :VoteGain => 0,
            :Description => "Mega Man face punch."
          }
        },
        {
          :Timestamp => "2016-07-11T05:31:24.9107237Z",
          :Creator => "sahart",
          :Targets => username,
          :Effect => {
            :EffectName => "Hard Knuckle",
            :EffectType => "Attack",
            :Duration => { :Case => "Instant"},
            :VoteGain => -100,
            :Description => "Mega Man face punch."
          }
        },
        {
          :Timestamp => "2016-07-11T05:31:06.6520379Z",
          :Creator => username,
          :Targets => username,
          :Effect => {
            :EffectName => "Varia Suit",
            :EffectType => "Gain",
            :Duration => {
              :Case => "StatusEffect",
              :Fields => [{ :Case => "Temporal",:Fields => ["01:00:00"]}]
            },
            :VoteGain => 0,
            :Description => "Sleek pant suit offering significant protection from foes."
          }
        },
      ]
    end

  private

    def post(path)
      @logger.info path
    end

  end
end
