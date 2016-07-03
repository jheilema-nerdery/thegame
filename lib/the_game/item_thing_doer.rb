module TheGame
  class ItemThingDoer
    def initialize(thing)
      @thing = thing
    end

    def save
      open('tmp/items.list', 'a') do |f|
        f.puts @thing.to_json
      end
    end

    def do
      case @thing[:Fields].first[:Name]
        # one-time, positive
      when "UUDDLRLRBA",                    # random, 3-100?
            "Bo Jackson",                   # 7
            "Buffalo",                      # 100
            "Wedge",                        # 50
            "Biggs",                        # 50
            "Pizza",                        # 50
            "Pokeball",                     # 35
            "Bullet Bill",                  # ? seems to hit other people?
            "Da Da Da Da Daaa Da DAA da da" # 10
        myself = { :PlayerName => 'jheilema' }
        ThingUser.new(@thing, myself).do
          # effects over time, positive
      when "Moogle",                       # *3, 1/5 chance. 30m
          "7777",                          # *7
          "Warthog",                       # *2
          "Rush the Dog",                  # *10, 1/8 chance. 1h. sidekick
          "Miniature Giant Space Hamster", # *10, 1/10 chance. overwrites RtD?
          "Chocobo",                       # badge
          "Pony",                          # badge
          "Leeroy Jenkins",
          "Cardboard Box",                 # ???? (hides?)
          "Princess"                       # ?????
        myself = { :PlayerName => 'jheilema' }
        ThingUser.new(@thing, myself).do
      when "Hard Knuckle",    # -200
            "Buster Sword",   # 0 ?
            "Green Shell",    # -100
            "SPNKR",          # -100
            "Banana Peel",    # -100
            "Space Invaders", # ?????. Bypasses Tanooki Suit. 1h1m
            "Fire Flower",    # -35
            "Holy Water"      # -10 over 10 hits (-100)
        players = PlayerFinder.find_top
        player = players[0]
        player = (player[:PlayerName] == 'jheilema') ? players[1] : player
        ThingUser.new(@thing, player).do
      when "Red Shell"        # -100
        players = PlayerFinder.find_top
        player = players[0]
        if (player[:PlayerName] == 'jheilema')
          #  save it for later, I'm at the top of the list and it'll just hit me
          open('tmp/items.list', 'a') do |f|
            f.puts @thing.to_json
          end
          'try the red shell again later when not in first'
        else
          ThingUser.new(@thing, player).do
        end
      when "Mushroom",
          "Crowbar",
          "Box of Bees",
          "Rail Gun"        # 0 ?
        open('tmp/whatdo.list', 'a') do |f|
          f.puts @thing.to_json
        end
        'what do: ' + @thing[:Fields].first[:Name]
      else
        # "Blue Shell"      # hits the #1 person for a ton, take'm down a notch
        # "Charizard",      # -500
        # "Fus Ro Dah",     # silence someone
        # "Master Sword",   # minus a lot, a whole lot. more than the blue shell
        # "Hadouken",       # -25% on gained points, 15m
        # "Pandora's Box",  #
        # "Golden Gun",     #
        # "Tanooki Suit",   # seems to block bonus points, other effects...?
        #
        # "Carbuncle",      # protection ?
        # "Varia Suit",     # protection ?
        # "Gold Ring",      # protection ?
        open('tmp/save.list', 'a') do |f|
          ## save for later
          f.puts @thing.to_json
        end
        'saved for later: ' + @thing[:Fields].first[:Name]
      end
    end
  end
end
