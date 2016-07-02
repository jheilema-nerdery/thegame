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
    when "UUDDLRLRBA",
          "Moogle",
          "Bo Jackson",
          "Biggs",
          "Wedge",
          "7777",
          "Warthog",
          "Chocobo",
          "Charizard",
          "Cardboard Box",
          "Tanooki Suit",
          "Varia Suit",
          "Gold Ring",
          "Buffalo",
          "Pizza",
          "Da Da Da Da Daaa Da DAA da da"
      myself = { :PlayerName => 'jheilema' }
      ThingUser.new(@thing, myself).do
    when "Hard Knuckle",
          "Buster Sword",
          "Green Shell",
          "Red Shell",
          "SPNKR",
          "Hadouken",
          "Banana Peel",
          "Crowbar",
          "Space Invaders",
          "Fire Flower",
          "Holy Water"
      players = PlayerFinder.find_top
      player = players[0]
      player = (player[:PlayerName] == 'jheilema') ? players[1] : player
      ThingUser.new(@thing, player).do
    when "Mushroom"
      'ugh stahp shrroms'
    else
      open('items.list', 'a') do |f|
        ## save for later
        f.puts @thing.to_json
      end
      'saved for later: ' + @thing[:Fields].first[:Name]
    end
  end
end
