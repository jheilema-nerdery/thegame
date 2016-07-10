class TheGame
  module Strategy
    class Presents
      def initialize(logger, api)
        @logger = logger
        @api = api
      end

      def use_items?
        true
      end

      def try_again_in
        5
      end

      def choose_item_and_player(players, jen, username)
        item = find_item
        return [] if item.nil?
        @logger.debug "#{item.name} chosen"

        return [item, username]
      end

      def find_item
        item_types = ItemLibrary::PRESENTS
        Item.unused.oldest.where(name: item_types).first
      end
    end
  end
end
