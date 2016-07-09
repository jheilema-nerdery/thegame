class TheGame
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

    def choose_item_and_player(players, jen)
      job = Job.oldest.first
      if job
        @logger.debug '-'*20 + "  Job Found: #{job.item_name} for #{job.target}  " + '-'*20
        target = job.target
        item = Item.unused.oldest.where(name: job.item_name).first
        job.delete if item
      end

      if item
        # record the player status so we can figure out what works
        @logger.info players.find{|p| p[:PlayerName] == target }
        return [item, target]
      end

      []
    end

  end
end
