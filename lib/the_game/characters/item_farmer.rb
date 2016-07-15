class TheGame
  module Characters
    class ItemFarmer
      def initialize(strategy, api, start, logger, username)
        @api         = api
        @next_attack = Time.now
        @next_tick   = Time.now + 1.minute
        @logger      = logger
        @username    = username
        @startup     = true
      end

      def attack!(leaders, jen)
        @player = fetch_current_player
        @logger.info "Item farmer found - #{@username} #{@player.points}"

        if @player.points > 1
          @logger.info "Item farmer: Reducing points"
          reduce_points
          @next_attack = Time.now + 60
          return
        end

        if @player.points == 1 && !@player.effects.include?('Fus Ro Dah')
          @logger.info "Fus Ro Dah'ing it up"
          result = fus_ro_dah
          if result
            @next_tick = Time.now
            @next_attack = Time.now + 5.minutes
            return
          else
            @next_tick = Time.now + 10.seconds
            @next_attack = Time.now + 1.second
          end
        end

        if @player.points < 1
          @next_tick = Time.now
          @next_attack = Time.now + (-@player.points.seconds)
        end
      end

      def next_tick
        @logger.info "Next Tick checked: #{@next_tick}"
        @next_tick
      end

      def next_attack
        @logger.info "Next attack checked: #{@next_attack}"
        @next_attack
      end

      def tick
        @logger.info "Time.now < @next_attack #{Time.now < @next_attack}"
        if Time.now < @next_attack
          @logger.info "Tick!"
          handle_turn(@api.tick)
          @next_tick = Time.now + 1.005
        end
      end

      def use_items?
        true
      end

    private

      def reduce_points
        item = if @player.points > 500
          Item.unused.oldest.named("Charizard").first
        else
          Item.unused.oldest.named("Fire Flower").first
        end

        use_item(item)
      end

      def fus_ro_dah
        item = Item.unused.oldest.named("Fus Ro Dah").first
        use_item(item)
      end

      def get_fus_ro_da_applied_at
        effects = @api.effects(@username)
        return Time.now - 6.minutes if @api.errors?

        last_frd = effects.find do |e|
          e[:Targets] == @username &&
          e[:Effect].present? &&
          e[:Effect][:EffectName] == "Fus Ro Dah"
        end

        @logger.info("FDR Found: #{Time.parse(last_frd[:Timestamp])}") if last_frd.present?
        return Time.parse(last_frd[:Timestamp]) if last_frd.present?
        Time.now - 6.minutes # can't find it in the list, assume it was a long time ago
      end

      def use_item(thing)
        @logger.info "Using #{thing.name} on #{@username}"
        @logger.debug "ThingUser.new(#{@api.class}, #{thing.name} #{thing.api_id}, #{@username}).do"
        result = ThingUser.new(@api, thing, @username).do

        @logger.info result

        if result.is_a?(String)
          return false
        end
        if invalid_item?(result)
          return false
        end

        true
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

      def fetch_current_player
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
          "An error has occurred.",
        ].any?{|m| m == result[:Message] }
      end

    end
  end
end
