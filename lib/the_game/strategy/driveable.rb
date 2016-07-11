class TheGame
  module Strategy
    class Driveable
      def initialize(logger, api)
        @logger = logger
        @api = api
      end

      def use_items?
        true
      end

      def try_again_in
        10
      end

      def choose_item_and_player(players, jen, username)
        job = Job.oldest.first
        if job
          @logger.debug "Job Found: #{job.item_name} for #{job.target}"
          target = job.target
          item = Item.unused.oldest.where(name: job.item_name).first
        end

        if item
          # record the player status so we can figure out what works
          @logger.info players.find{|p| p[:PlayerName] == target }
          return [item, target, job]
        end

        @logger.info "No item found for Job #{job.id} - #{job.item_name}"
        job.delete
        []
      end
    end
  end
end
