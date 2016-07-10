namespace :the_game do

  desc "Do things"
  task play: :environment do
    # Setup
    configs     = TheGame::FileReadAndClearer.new('.config').get
    puts configs
    start_time  = Time.now + 30.seconds

    # get players
    players = configs.map do |player|
      api_key     = player[:api_key] or raise 'set your api key!'
      username    = player[:username] or raise 'set your username!'
      logger      = TheGame::DecoratedLogger.new(username, ENV["DEBUG"])
      api         = TheGame::Api.new(logger, api_key)
      start_time  = start_time + 5.seconds

      game = TheGame.new(player[:strategy], api, start_time, logger, username)
      game.add_strategies(player[:strategies]) if player[:strategies]
      game
    end

    players.each do |player|
      sleep 0.5 # so they don't all overlap

      Thread.new do
        loop do
          sleep 0.32
          if Time.now > player.tick_time
            player.tick
          end
          if player.use_items?
            if Time.now > player.attack_time
              player.attack!
            end
          end
        end
      end.abort_on_exception = true
    end

    interrupted = false
    trap("INT") { interrupted = true } # traps Ctrl-C
    puts 'Press Ctrl-C to exit'

    loop do
      break if interrupted
      sleep 1
    end

  end



end
