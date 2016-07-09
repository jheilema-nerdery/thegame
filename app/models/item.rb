class Item < ActiveRecord::Base
  scope :unused, ->{ where(used: false) }
  scope :used,   ->{ where(used: true) }
  scope :oldest, ->{ order(:updated_at) }
  scope :newest, ->{ order(:updated_at => :desc) }
  scope :named,  ->(name){ where(name: name) }

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
    # if there was a timeout, then we don't want to get rid of the item
    if json.is_a? String && json.include? "Curl::Err"
      return
    end

    self.used = true
    self.action = json.to_s
    save
  end
end
