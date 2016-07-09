class TheGame
  class ItemLibrary
    POSITIVE = [
      "Buffalo",                         # 100
      "UUDDLRLRBA",                      # random, 3-100?
      "Wedge",                           # 50
      "Biggs",                           # 50
      "Pizza",                           # 50
      "Pokeball",                        # 35, bonus item
      "Da Da Da Da Daaa Da DAA da da",   # 10, bonus item
      "Treasure Chest",                  # 3 bonus items
    ]

    EFFECT_OVER_TIME = [
      "7777",                           # *7, 7m
      "Warthog",                        # *2, 15m
      "Moogle",                         # *3, 1/5 chance. 30m
      "Rush the Dog",                   # *10, 1/8 chance. 1h. sidekick
    ]

    BADGE = [
      "Chocobo",
      "Pony",
      "Fat Guys",
      "Skinny Guys",
      "Roger Wilco",
      "Power Pellet: Inky",   # trolling. rarity 4
      "Power Pellet: Blinky",
      "Nintendo Controller",
      "Zelda Cartridge",
      "Triforce of Wisdom",
      "Triforce of Power",
      "Triforce Of Courage",
      "Ocarina of Time",
    ]

    PROTECTION = [
      "Cardboard Box",  # ???? (hides?)
      "Varia Suit",     # 1h. Holy water, Master sword gets through
      "Carbuncle",      # 5m "reflects" damage (inverts it? O_o)
      "Star",           # 5m temporary invincibility
      "Gold Ring",      # protection, 3m - blocks bo jackson... others?
      "Tanooki Suit",   # blocks 3 effects
    ]

    SWAP_PLACES = [
      "Bullet Bill",    # Move up a few people. Stop hitting yourself.
      "Get Over Here",  # Chance to cuddle up to your opponent.
      "Morph Ball",     # Transform into a sphere that passes two players?
    ]

    ALL_POSITIVE = POSITIVE + EFFECT_OVER_TIME + BADGE + PROTECTION + SWAP_PLACES

    WEAPON = [
      "Buster Sword",   # -500
      "Charizard",      # -500
      "Hadouken",       # -25% on gained points, 15m. ~225 at base rate
                        # plus additional YOU GOT BURNED (%?)
      "Hard Knuckle",   # -200
      "Holy Water",     # -10 over 10 hits (-100)
    ]

    PRICK = [
      "Green Shell",    # -100
      "SPNKR",          # -100
      "Banana Peel",    # -100
      "Fire Flower",    # -35
      "Rail Gun",       # 0 ?
    ]

    CLOSE_RANGE = [
      "Crowbar",        # -200, hits the person in front of you
      "Red Shell",      # -100 Usually hits the person in front.
                        # If you're in front, it hits you.
    ]

    BIG_GUN = [
      "Blue Shell",     # hits the #1 person for a ton, take'm down a notch
      "Master Sword",   # minus a lot, a whole lot. more than blue shell
      "Golden Gun",     # huge damage, ~ 45000 when it hit colin
      "Red Crystal",    # "Simon's quest" badge
    ]

    UNHELPFUL = [
      "Mushroom",       # 50% chance for *0.5 or *2, 5m
      "Leeroy Jenkins", # adds a battle yell
      "Portal Nun",
      "Box of Bees",
      "Bo Jackson",     # 7
      "Pandora's Box",  # don't open it
      "Space Invaders", # ?????. Bypasses Tanooki Suit. 1h1m. disabled rn.
      "Miniature Giant Space Hamster",  # annoying message in my logs
    ]

    SILENCE = [
      "Fus Ro Dah",     # silence someone, 5m
    ]

    DONT_KNOW = [
      "Jigglypuff",           # Points for cuteness.
      "Portal Gun",           # The cake is a lie!
      "Princess",             # kiss from her majesty turns frog into prince
      "Goomba",               # Angry round monster. rarity 4
      "Cthulhu",              # effs with your messages
      "Leisure Suit"          # Winning this game is about as easy as holding
                              # onto a mud wrestler!
    ]

    ALL = POSITIVE + EFFECT_OVER_TIME + BADGE + WEAPON + PRICK +
      CLOSE_RANGE + BIG_GUN + PROTECTION + UNHELPFUL + SILENCE +
      SWAP_PLACES + DONT_KNOW
  end
end
