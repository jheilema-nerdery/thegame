namespace :the_game do

  desc "Do things"
  task points: :environment do
    # Setup
    API_KEY            = ENV["API_KEY"] or raise 'set your api key!'
    Rails.logger       = ENV["DEBUG"] ? Logger.new(STDOUT) : Rails.logger
    Rails.logger.level = ENV["DEBUG"] ? 0 : 1

    api         = TheGame::Api.new(Rails.logger, API_KEY)
    strat_class = ENV["STRATEGY"] ? ENV["STRATEGY"].constantize : TheGame::Flexible
    strategy    = strat_class.new(Rails.logger, api)
    attack_time = Time.now + 30.seconds

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
          if Time.now > (attack_time)
            attack_time = attack!(api, strategy)
          end
        end
      end
    end

    loop do
      turn = api.tick
      sleep handle_turn(turn)
    end
  end

  def attack!(api, strategy)
    players = api.players
    if errors?(players)
      return Time.now + strategy.try_again_in.seconds
    end

    jen = api.jen
    if errors?(jen)
      return Time.now + strategy.try_again_in.seconds
    end

    Rails.logger.debug "====== Players, Jen Found - #{strategy.class}  ======"

    thing, player = strategy.choose_item_and_player(jen[:Effects], players, jen[:Points])

    if !thing
      Rails.logger.info "====== no item chosen ========"
      return Time.now + strategy.try_again_in
    end

    Rails.logger.info "====== using an item ========"
    Rails.logger.debug "ThingUser.new(#{api.class}, #{thing.name} #{thing.api_id}, #{player}).do"
    result = TheGame::ThingUser.new(api, thing, player).do

    Rails.logger.info result
    if result.is_a? String
      return Time.now + strategy.try_again_in
    else
      return Time.now + 60
    end
  end

  def handle_turn(turn)
    if errors? turn
      return 10
    end

    if !turn[:Item].nil?
      Item.from_json(turn[:Item]).save
      Rails.logger.info turn
    end

    return 1
  end

  def errors?(result)
    if result.is_a? String
      Rails.logger.info result
      return true
    end
    false
  end

end
