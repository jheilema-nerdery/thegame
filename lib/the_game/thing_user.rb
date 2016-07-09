class TheGame
  class ThingUser
    def initialize(api, thing, person = nil)
      @api = api
      @thing = thing
      @person = person
    end

    def do
      itemid = @thing.api_id

      result = if @person.nil?
        @api.use(itemid)
      else
        @api.use_on(itemid, @person)
      end

      @thing.update_from(result)
      result
    end

  end
end
