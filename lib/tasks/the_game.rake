namespace :the_game do
  desc "Do things"
  task points: :environment do

    # /items/use/{itemid}?target={target-userid}
    #
    # ***REMOVED***
    # ***REMOVED***

    # Setup
    API_KEY            = ENV["API_KEY"] or raise 'set your api key!'
    Rails.logger       = ENV["DEBUG"] ? Logger.new(STDOUT) : Rails.logger
    Rails.logger.level = ENV["DEBUG"] ? 0 : 1

    api_class = ENV["API_HANDLER"] ? ENV["API_HANDLER"].constantize : TheGame::Api
    api       = api_class.new(Rails.logger, API_KEY)
    strategy_class  = ENV["STRATEGY"] ? ENV["STRATEGY"].constantize : TheGame::HoldingPattern
    strategy  = strategy_class.new(Rails.logger, api)
    counter   = 40

    # allow Ctrl+C to quit
    Thread.new do
      loop do
        exit if gets.chomp == 'q'
      end
    end

    loop do
      begin
        counter += 1
        turn = api.tick
        sleep 1

        unless turn[:Item].nil?
          Item.from_json(turn[:Item]).save
          Rails.logger.info turn
        end

        if counter >= strategy.time_to_wait
          counter = 0
          Rails.logger.debug "Effects: #{turn[:Effects]}"

          players = api.players
          thing, player = strategy.choose_item_and_player(turn[:Effects], players)

          if thing && player
            Rails.logger.info "====== using an item ========"
            Rails.logger.debug "ThingUser.new(#{api.class}, #{thing.name} #{thing.api_id}, #{player[:PlayerName]}).do"
            result = TheGame::ThingUser.new(api, thing, player).do

            Rails.logger.info result
          else
            Rails.logger.info "====== no item chosen ========"
          end
        end
      rescue Curl::Err::RecvError
        Rails.logger.error "*"*20 + '  Rescuing from a timeout  ' + "*"*20
        sleep 120
      end
    end

  end

end
