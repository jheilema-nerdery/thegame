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
