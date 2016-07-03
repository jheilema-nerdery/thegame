class Item < ActiveRecord::Base
  def self.from_json(json_data)
    fields = json_data[:Fields][0]
    new(
      :case        => json_data[:Case],
      :name        => fields[:Name],
      :api_id      => fields[:Id],
      :rarity      => fields[:Rarity],
      :description => fields[:Description],
    )
  end
end
