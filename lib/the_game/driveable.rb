module TheGame
  class Driveable
    def initialize(logger, api)
      @logger = logger
      @api = api
    end

    def time_to_wait
      60
    end

    def choose_item_and_player(current_effects = [], players)
      job = Job.oldest.first
      if job
        @logger.debug '-'*20 + "  Job Found: #{job.item_name} for #{job.target}  " + '-'*20
        target = job.target
        item = Item.unused.oldest.where(name: job.item_name).first
        job.delete if item
      end
      return [item, target] if job && item
      []
    end

  end
end
