class TheGame
  module Strategy
    class KeepUp < BaseStrategy
      def initialize(logger, api)
        @logger = logger
        @api = api
        @players = []
        @jen = nil
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

        above  = @players[index-1] unless index.nil?
        second = @players[index-2] unless index.nil? || index <= 1
        third  = @players[index-3] unless index.nil? || index <= 2

        # don't want to mom voice myself
        return nil if above

        item_types = []

        if index.nil? # not in the top ten
          item_types << "Morph Ball"
          item_types << "Bullet Bill"
          item_types << "Cardboard Box"
          return Item.unused.oldest.where(name: item_types).first
        end

        if third && !sheilded?(third)
          return Item.unused.oldest.where(name: "Bullet Bill").first
        end

        if second && !sheilded?(second)
          return Item.unused.oldest.where(name: "Morph Ball").first
        end

        if above && !sheilded?(above)
          return Item.unused.oldest.where(name: "Cardboard Box").first
        end

        return nil
      end

      def sheilded?(player)
        player.wearing?(['Star','Gold Ring','Tanooki Suit','Morger Beard'])
      end

      def too_close(player)
        player.score >= (::SUSPICIOUS_POINTS - points_left)
      end

      def points_left
        (Time.now - ::FINALE).to_i
      end

    end
  end
end
