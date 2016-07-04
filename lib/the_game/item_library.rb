module TheGame
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
      "Bo Jackson",                      # 7
    ]

    EFFECT_OVER_TIME = [
      "7777",                           # *7
      "Warthog",                        # *2
      "Moogle",                         # *3, 1/5 chance. 30m
      "Rush the Dog",                   # *10, 1/8 chance. 1h. sidekick
      "Miniature Giant Space Hamster",  # *10, 1/10 chance. overwrites RtD?
                                        # possibly has other interactions
    ]

    BADGE = [
      "Chocobo",
      "Pony",
      "Fat Guys",
      "Skinny Guys",
      "Roger Wilco",
    ]

    WEAPON = [
      "Hadouken",       # -25% on gained points, 15m. ~225 at base rate
      "Hard Knuckle",   # -200
      "Green Shell",    # -100
      "SPNKR",          # -100
      "Banana Peel",    # -100
      "Holy Water",     # -10 over 10 hits (-100)
      "Fire Flower",    # -35
      "Rail Gun",       # 0 ?
    ]

    CLOSE_RANGE = [
      "Crowbar",        # -200, hits the person in front of you
      "Red Shell",      # -100 Usually hits the person in front.
                        # If you're in front, it hits you.
    ]

    BIG_WEAPON = [
      "Blue Shell",     # hits the #1 person for a ton, take'm down a notch
      "Master Sword",   # minus a lot, a whole lot. more than blue shell
      "Golden Gun",     # huge damage, ~ 45000 when it hit colin
      "Bullet Bill",    # ? seems to hit other people?
      "Charizard",      # -500
      "Buster Sword",   # -500
      "Red Crystal",    # ?
    ]

    PROTECTION = [
      "Cardboard Box",  # ???? (hides?)
      "Varia Suit",     # 1h
      "Carbuncle",      # 5m
      "Gold Ring",      # protection ?
      "Tanooki Suit",   # blocks 3 effects
    ]

    UNHELPFUL = [
      "Mushroom",
      "Box of Bees",
      "Morph Ball",     # Transform into a sphere that passes two players?
      "Pandora's Box",  # don't open it
      "Space Invaders", # ?????. Bypasses Tanooki Suit. 1h1m. disabled rn.
    ]

    SILENCE = [
      "Fus Ro Dah",     # silence someone
    ]

    ALL = POSITIVE + EFFECT_OVER_TIME + BADGE + WEAPON + CLOSE_RANGE +
          BIG_WEAPON + PROTECTION + UNHELPFUL + SILENCE
  end
end
