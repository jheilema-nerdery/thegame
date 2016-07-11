class TheGame
  def initialize(strategy, api, start, logger, username)
    @api         = api
    @next_attack = start
    @next_tick   = Time.now
    @logger      = logger
    @strategy    = fetch_strategy(strategy, logger, api)
    @username    = username
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

  def add_strategies(strategies)
    @strategy.add_strategy(*strategies)
  end

private

  def fetch_strategy(name, logger, api)
    strat_class = ("TheGame::Strategy::" + name).constantize
    strat_class.new(logger, api)
  end

  def handle_turn(turn)
    if errors? turn
      return false
    end

    if !turn[:Item].nil?
      Item.from_json(turn[:Item]).save
      @logger.info turn
    end

    return true
  end

  def attack
    @players = fetch_players
    return false unless @players
    @jen = fetch_jen
    return false unless @jen
    @current_player = fetch_current_player

    @logger.debug "Players, Jen Found - #{@strategy.class}"
    thing, player_name, job = @strategy.choose_item_and_player(@players, @jen, @current_player)

    if !thing
      @logger.info "no item found, skipping"
      return false
    end

    @logger.info "Using #{thing.name} on #{player_name}"
    @logger.debug "ThingUser.new(#{@api.class}, #{thing.name} #{thing.api_id}, #{player_name}).do"
    result = ThingUser.new(@api, thing, player_name).do

    @logger.info result

    if invalid_item?(result)
      return false
    end
    if result.is_a?(String)
      return false
    end
    job.delete if job

    true
  end

  def fetch_players
    players_data = @api.players
    if errors?(players_data)
      return false
    end
    Player.all_from_json(players_data)
  end

  def fetch_jen
    jen_data = @api.jen
    if errors?(jen_data)
      return false
    end
    Player.new(jen_data)
  end

  def fetch_current_player
    return @jen if @username == 'jheilema'
    player = @players.find{|p| p.name == @username }
    return player if player

    current_player_data = @api.player(@username)
    if errors?(current_player_data)
      Player.stubbed(@username)
    else
      Player.new(current_player_data)
    end
  end

  def errors?(result)
    if result.is_a? String
      @logger.info result
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
