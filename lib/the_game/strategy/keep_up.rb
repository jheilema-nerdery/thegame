class TheGame
  module Strategy
    class KeepUp < BaseStrategy
      def initialize(logger, api)
        @logger = logger
        @api = api
        @players = []
        @jen = nil
      end

      def try_again_in
        5
      end

      def choose_item_and_player(players, jen, current_player)
        @players = players
        @jen = jen

        item = find_item

        return [] if item.nil?
        @logger.debug "#{item.name} chosen"

        return item, 'jheilema'
      end

    private

      def find_item
        index = @players.find_index(@jen)

        if index == 1 || index == 0
          return nil # I'm in first/second! woo!
        end

        next_player = @players[index-1] unless index.nil?

        # don't want to mom voice myself
        retun nil if next_player && next_player.score >= (SUSPICIOUS_POINTS - 10_000)

        item_types = []

        if index.nil? # not in the top ten
          item_types << "Morph Ball"
          item_types << "Bullet Bill"
        end

        if !index.nil? && percent_diff(next_player.score, @jen.score) >= 0.05 && !next_player.wearing?(['Star','Gold Ring','Tanooki Suit','Morger Beard'])
          item_types << "Cardboard Box"
        end

        return nil if item_types.empty?

        Item.unused.oldest.where(name: item_types).first
      end


      def percent_diff(first, second)
        (first.to_f - second) / first
      end

    end
  end
end
