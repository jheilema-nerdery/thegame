class TheGame
  module Strategy
    class Driveable < BaseStrategy
      def choose_item_and_player(players, jen, current_player)
        job = Job.oldest.first
        return [] unless job

        @logger.debug "Job Found: #{job.item_name} for #{job.target}"
        target = job.target
        item = Item.unused.oldest.where(name: job.item_name).first

        unless item
          @logger.info "No item found for Job #{job.id} - #{job.item_name}"
          job.delete
          return []
        end

        # record the player status so we can figure out what works
        @logger.info "Targeting #{target} with #{item.name}"
        return [item, target, job]
      end
    end
  end
end
