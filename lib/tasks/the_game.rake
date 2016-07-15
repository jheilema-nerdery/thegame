namespace :the_game do

  desc "Do things"
  task play: :environment do
    # Setup
    configs     = TheGame::FileReadAndClearer.new('.config').get
    puts configs
    start_time  = Time.now + 3.seconds
    FINALE      = Time.parse('July 15 2016 16:00:00 CDT')
    CRAZY_TIME  = FINALE - 45.minutes
    SUSPICIOUS_POINTS = 1_337_133_713_370

    # get players
    players = configs.map do |build|
      api_key     = build[:api_key] or raise 'set your api key!'
      username    = build[:username] or raise 'set your username!'
      logger      = TheGame::DecoratedLogger.new(username, ENV["DEBUG"])
      api         = TheGame::Api.new(logger, api_key)
      start_time  = start_time + 5.seconds

      type        = build[:class] ? "TheGame::Characters::" + build[:class] : "TheGame::Characters::Basic"

      player = type.constantize.new(build[:strategy], api, start_time, logger, username)
      player.add_strategies(build[:strategies]) if build[:strategies]
      player
    end

    # don't really care about the api here b/c we don't utilize the key
    # for GET requests
    logger  = TheGame::DecoratedLogger.new('fetcher', ENV["DEBUG"])
    api     = TheGame::Api.new(logger, '')
    fetcher = TheGame::PlayerFinder.new(api)

    Thread.new do
      loop do
        fetcher.fetch_leaderboard
        sleep 1 # don't kill the server
      end
    end.abort_on_exception = true

    Thread.new do
      loop do
        logger.debug 'Fetching jen'
        fetcher.fetch_jen
        sleep 1 # don't kill the server
      end
    end.abort_on_exception = true

    players.each do |player|
      Thread.new do
        loop do
          sleep 0.32
          if player.use_items?
            if Time.now > player.next_attack
              player.attack!(fetcher.leaders, fetcher.jen)
            end
          end
          if Time.now > player.next_tick
            player.tick
          end
        end
      end.abort_on_exception = true

      sleep 0.5 # so they don't all overlap
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
