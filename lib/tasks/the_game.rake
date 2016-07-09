namespace :the_game do

  desc "Do things"
  task points: :environment do
    # Setup
    api_key  = ENV["API_KEY"] or raise 'set your api key!'
    username = ENV["USERNAME"] or raise 'set your username!'
    logger   = TheGame::DecoratedLogger.new(username, ENV["DEBUG"])

    api         = TheGame::Api.new(logger, api_key)
    strat_class = ENV["STRATEGY"] ? ("TheGame::" + ENV["STRATEGY"]).constantize : TheGame::Flexible
    strategy    = strat_class.new(logger, api)
    start_time  = Time.now + 30.seconds

    game = TheGame.new(strategy, api, start_time, logger)

    # allow Ctrl+C to quit
    Thread.new do
      loop do
        exit if gets.chomp == 'q'
      end
    end

    if strategy.use_items?
      t = Thread.new do
        loop do
          sleep 0.32
          if Time.now > game.attack_time
            game.attack!
          end
        end
      end
      t.abort_on_exception = true
    end

    loop do
      game.tick
    end
  end



end
