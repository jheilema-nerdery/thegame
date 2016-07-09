namespace :the_game do

  desc "Do things"
  task points: :environment do
    # Setup
    API_KEY            = ENV["API_KEY"] or raise 'set your api key!'
    Rails.logger       = ENV["DEBUG"] ? Logger.new(STDOUT) : Rails.logger
    Rails.logger.level = ENV["DEBUG"] ? 0 : 1

    api         = TheGame::Api.new(Rails.logger, API_KEY)
    strat_class = ENV["STRATEGY"] ? ("TheGame::" + ENV["STRATEGY"]).constantize : TheGame::Flexible
    strategy    = strat_class.new(Rails.logger, api)
    start_time  = Time.now + 30.seconds

    game = TheGame.new(strategy, api, start_time, Rails.logger)

    # allow Ctrl+C to quit
    Thread.new do
      loop do
        exit if gets.chomp == 'q'
      end
    end

    if strategy.use_items?
      Thread.new do
        loop do
          sleep 0.32
          if Time.now > game.attack_time
            game.attack!
          end
        end
      end
    end

    loop do
      game.tick
    end
  end



end
