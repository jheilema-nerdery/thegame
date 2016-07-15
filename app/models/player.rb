class Player
  attr_reader :name, :points, :badges, :effects

  def initialize(player_data)
    @name = player_data[:PlayerName]
    @points = player_data[:Points]
    @badges = extract_badges(player_data[:Badges]) if player_data[:Badges]
    @effects = player_data[:Effects]
  end

  def self.all_from_json(player_datas)
    player_datas.map do |p|
      new(p)
    end
  end

  def self.stubbed(username)
    new({:PlayerName => username, :Points => 0, :Badges => [], :Effects => []})
  end

  def ==(player)
    self.name == player.name
  end

  def score
    points
  end

  def wearing?(items)
    !(effects & items).empty?
  end

  def vampire?
    self.badges.include? 'Vampire'
  end

private

  def extract_badges(array_of_hashes)
    array_of_hashes.map{|h| h[:BadgeName] }
  end
end
