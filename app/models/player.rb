class Player
  attr_reader :name, :points, :badges, :effects

  def initialize(player_data)
    @name = player_data[:PlayerName]
    @points = player_data[:Points]
    @badges = extract_badges(player_data[:Badges])
    @effects = player_data[:effects]
  end

   def self.all_from_json(player_datas)
    player_datas.map do |p|
      new(p)
    end
  end

private

  def extract_badges(array_of_hashes)
    array_of_hashes.map{|h| h[:BadgeName] }
  end
end
