class Item < ActiveRecord::Base
  scope :unused, ->{ where(used: false) }
  scope :oldest, ->{ order(:updated_at) }

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

  def update_from(json)
    self.used = true
    self.action = json.to_s
    save
  end
end
