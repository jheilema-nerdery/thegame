namespace :the_game do

  desc "Do things"
  task play: :environment do
    # Setup
    configs     = TheGame::FileReadAndClearer.new('.config').get
    puts configs
    start_time  = Time.now + 30.seconds

    # get players
    players = configs.map do |build|
      api_key     = build[:api_key] or raise 'set your api key!'
      username    = build[:username] or raise 'set your username!'
      logger      = TheGame::DecoratedLogger.new(username, ENV["DEBUG"])
      api         = TheGame::Api.new(logger, api_key)
      start_time  = start_time + 5.seconds

      type        = build[:class] ? "TheGame::Player::" + build[:class] : "TheGame::Player::Basic"

      player = type.constantize.new(build[:strategy], api, start_time, logger, username)
      player.add_strategies(build[:strategies]) if build[:strategies]
      player
    end

    players.each do |player|
      sleep 0.5 # so they don't all overlap

      Thread.new do
        loop do
          sleep 0.32
          if player.use_items?
            if Time.now > player.attack_time
              player.attack!
            end
          end
          if Time.now > player.tick_time
            player.tick
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
