class TheGame
  def initialize(strategy, api, start, logger)
    @strategy    = strategy
    @api         = api
    @next_attack = start
    @next_tick   = Time.now
    @logger      = logger
  end

  def attack_time
    @next_attack
  end

  def tick_time
    @next_tick
  end

  def attack!
    if attack
      @next_attack = Time.now + 60
    else
      @next_attack = Time.now + @strategy.try_again_in.seconds
    end
  end

  def tick
    if handle_turn(@api.tick)
      @next_tick = Time.now + 1.005
    else
      @next_tick = Time.now + 10
    end
  end

  def use_items?
    @strategy.use_items?
  end

private

  def handle_turn(turn)
    if errors? turn
      false
    end

    if !turn[:Item].nil?
      Item.from_json(turn[:Item]).save
      @logger.info turn
    end

    return true
  end

  def attack
    players = @api.players
    if errors?(players)
      return false
    end

    jen = @api.jen
    if errors?(jen)
      return false
    end

    @logger.debug "Players, Jen Found - #{@strategy.class}"
    thing, player = @strategy.choose_item_and_player(players, jen)

    if !thing
      @logger.info "no item chosen"
      return false
    end

    @logger.info "using an item"
    @logger.debug "ThingUser.new(#{@api.class}, #{thing.name} #{thing.api_id}, #{player}).do"
    result = ThingUser.new(@api, thing, player).do

    @logger.info result

    if result.is_a?(String) || invalid_item?(result)
      return false
    else
      return true
    end
  end

  def errors?(result)
    if result.is_a? String
      Rails.logger.info result
      return true
    end
    false
  end

  def invalid_item?(result)
    [
      "Invalid item GUID",
      "The request is invalid.",
    ].any?{|m| m == result[:Message] }
  end


end
