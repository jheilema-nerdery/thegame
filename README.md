Start in `/lib/tasks/the_game.rake`. Most of the functionality is contained in `/lib/the_game/`, including strategies, timing, and api interactions. There are a couple of ActiveRecord models for storing Items and Jobs, and a vanilla Ruby object for interacting with player objects.

To get it up and running
    - install ruby
    - bundle install 
    - create a `.config` file in the root of the project, with one API key and config per line in json format. 
        
    It's shitty but whatever i didn't care to read about ruby File in the moment and it works. 

    Should be formatted like this:

    {"api_key":"fc72027b-7957-4265-bae9-5680676e5a48","username":"jheilema", "strategy":"Prioritized","strategies":["Driveable", "Invuln", "PortalGun", "KeepUp", "Varia"]}
    {"api_key":"27b11c03-6d5b-4118-aa00-d700e260728c", "username":"ssiegert", "strategy":"Rekt"}
    {"api_key":"fcbedf9a-0155-47cf-adac-5a5e7b5c035d", "username":"ziniguez", "strategy":"MomVoice"}
    {"api_key":"441f61a9-e091-477b-a16e-599bc9476fab", "username":"sbausch", "strategy":"ItemFarmer"}

You can add as many users as your database connections can handle. 

Run the game with:
    
    $ rake the_game:play

Strategies can either be individually focused by just setting "strategy" to one of the strategies; alternatively, the RoundRobin or Prioritized strategy can be chosen, then a list of "strategies" is expected. 

RoundRobin loops through the list until it finds a strategy that works (or gets through everything once; next attack will start with the strat after the previous successful one). 

Prioritized works through the list in order, until it finds a strategy that works.

## Functionality I missed.
I regret not holding onto one of the Wreck-it Ralphs for the very last seconds.

I needed a queuing system for jobs, they're first-come, first-served the way they're set up now, with no way to differentiate which "player" would pick up the job. 

The item farmer is imperfect; I attempted to refactor to create a "character" class that could either be 'Basic' or an ItemFarmer; it never worked and I didn't have time to figure out why.

The bus had shitty wifi.

## Stats

15 API keys, including my own. At last check, 8 of them were vampires.

5 different EC2 instances at various points. I was mucking around in them and killing memory by running multiple rake tasks for each api key. Once I switched over to all the players in one multi-threaded rake task, I put everything into a single RDS database and EC2 instance, sized "small".

I identified for sure two other botnets, one in KS (Team Bill Nye, supporting Ryan Evans, I spotted 6 suspects) and one in MN (Team Darwin, supporting Theo Kanning, I spotted 8 suspects, including Mr Kanning). 

272,257 items. 68,422 used, 203,835 not used. 0 Wreck-it Ralphs at the end, but the high count just before the madness happened was 37.

| Item Name  | # Used | # Unused |
| ---------- | ------ | -------- |
| 7777 | 93 | 1956 |
| Ambrosia | 2 | 98 |
| Banana Peel | 3238 | 5281 |
| Biggs | 662 | 7735 |
| Blue Shell | 84 | 2120 |
| Bo Jackson | 3250 | 5279 |
| Box of Bees | 45 | 2138 |
| Buffalo | 329 | 8255 |
| Bullet Bill | 167 | 2040 |
| Buster Sword | 1487 | 727 |
| CarbUncle | 0 | 590 |
| Carbuncle | 43 | 2131 |
| Cardboard Box | 585 | 7933 |
| Charizard | 6391 | 2452 |
| Chocobo | 35 | 2071 |
| Crowbar | 697 | 7753 |
| Cthulhu | 0 | 100 |
| Da Da Da Da Daaa Da DAA da da | 7099 | 1599 |
| Fat Guys | 55 | 2143 |
| Fire Flower | 3028 | 5324 |
| Fus Ro Dah | 574 | 1558 |
| Get Over Here | 55 | 2040 |
| Gold Ring | 1336 | 7375 |
| Golden Gun | 34 | 2041 |
| Goomba | 0 | 104 |
| Green Shell | 3123 | 5281 |
| Hadouken | 6825 | 1952 |
| Hard Knuckle | 6125 | 2387 |
| Holy Water | 6266 | 2430 |
| Jigglypuff | 1 | 107 |
| King Graham | 0 | 107 |
| Leeroy Jenkins | 37 | 2099 |
| Leisure Suit | 182 | 1995 |
| Master Sword | 700 | 1504 |
| Miniature Giant Space Hamster | 55 | 2204 |
| Moogle | 402 | 8281 |
| Morger Beard | 74 | 2043 |
| Morph Ball | 177 | 2026 |
| Mushroom | 1259 | 15375 |
| NES Controller | 2 | 100 |
| Ocarina of Time | 2 | 92 |
| Pandora's Box | 38 | 2075 |
| Pip-Boy | 0 | 169 |
| Pizza | 675 | 7801 |
| Pokeball | 6972 | 1559 |
| Pony | 40 | 2155 |
| Poroggo | 1 | 102 |
| Portal Gun | 43 | 70 |
| Portal Nun | 43 | 2078 |
| Power Pellet: Blinky | 2 | 95 |
| Power Pellet: Clyde | 1 | 85 |
| Power Pellet: Inky | 5 | 82 |
| Power Pellet: Pinky | 1 | 100 |
| Princess | 42 | 2067 |
| Rail Gun | 335 | 1837 |
| Red Crystal | 54 | 2119 |
| Red Shell | 691 | 7756 |
| Roger Wilco | 48 | 2135 |
| Rush the Dog | 88 | 2204 |
| SPNKR | 328 | 1899 |
| Skinny Guys | 48 | 2083 |
| Space Invaders | 3 | 0 |
| Star | 317 | 1822 |
| Tanooki Suit | 319 | 8325 |
| Treasure Chest | 1758 | 467 |
| Triforce of Courage | 2 | 102 |
| Triforce of Power | 3 | 89 |
| Triforce of Wisdom | 3 | 105 |
| UUDDLRLRBA | 665 | 7560 |
| Vanellope | 1 | 24 |
| Varia Suit | 170 | 2023 |
| Warthog | 483 | 8135 |
| Wedge | 683 | 7805 |
| Wreck-it Ralph | 40 | 0 |
| Zelda Cartridge | 1 | 81 |

