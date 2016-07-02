require './thingUser'
require './playerFinder'

class ItemThingDoer
  def initialize(thing)
    @thing = thing
  end

  def save
    open('items.list', 'a') do |f|
      f.puts @thing.to_json
    end
  end

  def do
    case @thing[:Fields].first[:Name]
      # one-time, positive
    when "UUDDLRLRBA",                    # random, 30-100?
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
    when "Moogle",            # random +2
          "7777",             # *7
          "Warthog",          # *2
          "Chocobo",          # badge
          "Pony",             # badge
          "Leeroy Jenkins",
          "Cardboard Box",    # ???? (hides?)
          "Princess"          # ?????
      myself = { :PlayerName => 'jheilema' }
      ThingUser.new(@thing, myself).do
    when "Hard Knuckle",    # -200
          "Buster Sword",   # 0 ?
          "Master Sword",   # ?
          "Green Shell",    # -100
          "Red Shell",      # -100
          "SPNKR",          # -100
          "Banana Peel",    # -100
          "Space Invaders", # ?????
          "Fire Flower",    # -35
          "Holy Water"      # -10 over 10 hits
      players = PlayerFinder.find_top
      player = players[0]
      player = (player[:PlayerName] == 'jheilema') ? players[1] : player
      ThingUser.new(@thing, player).do
    when false
      ThingUser.new(@thing).do
    when "Mushroom",
        "Crowbar",
        "Box of Bees",
        "Rail Gun"        # 0 ?
      open('whatdo.list', 'a') do |f|
        f.puts @thing.to_json
      end
      'what do: ' + @thing[:Fields].first[:Name]
    else
      # "Blue Shell"
      # "Charizard",
      # "Fus Ro Dah",
      # "Hadouken",
      # "Tanooki Suit",   # seems to block bonus points, other effects...?
      #
      # "Carbuncle",      # protection ?
      # "Varia Suit",     # protection ?
      # "Gold Ring",      # protection ?
      open('save.list', 'a') do |f|
        ## save for later
        f.puts @thing.to_json
      end
      'saved for later: ' + @thing[:Fields].first[:Name]
    end
  end
end
