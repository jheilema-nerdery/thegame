class TheGame
  module Strategy
    class ItemFarmer < BaseStrategy
      def initialize(logger, api)
        @logger = logger
        @api = api
        @window = Time.now
        @points = 1
      end

      def starting_tick
        Time.now + 5.seconds
      end

      def starting_attack(suggested)
        Time.now
      end

      def successful_tick
        if Time.now >= @window
          35
        else
          1.005
        end
      end

      def failed_tick
        10
      end

      def choose_item_and_player(players, jen, current_player)
        @points = current_player.points

        if current_player.points > 1
          @window = Time.now + 24.seconds
          item = Item.unused.oldest.named("Fire Flower").first
          return [item, current_player.name]
        end

        if current_player.points < 1
          @window = Time.now - @points + 2
          return []
        end

        if current_player.effects.include? "Fus Ro Dah"
          return []
        end

        item = Item.unused.oldest.named("Fus Ro Dah").first
        @window = Time.now + 4.9.minutes
        return [item, current_player.name]
      end
    end
  end
end
